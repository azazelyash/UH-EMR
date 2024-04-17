import 'dart:io';
import 'dart:developer';

import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/create_rx_usecase.dart';
import 'package:aasa_emr/features/rx_screen/domain/usecases/send_rx_to_patient_usecase.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';

import '../../../user/data/models/settings_model.dart';
import '../../../user/presentation/providers/user_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../../../../utils/pdf/pdf_utils.dart';
import 'package:provider/provider.dart';

import '../../../../common/provider/loading_provider.dart';

class RxProvider extends LoadingProvider {
  final CreateRxUseCase createRxUseCase;
  final SendRxToPatientUsecase sendRxToPatientUsecase;

  RxProvider({
    required this.createRxUseCase,
    required this.sendRxToPatientUsecase,
  });

  String _selectedGrade = "";
  String get selectedGrade => _selectedGrade;

  int _discountValue = 0;
  int get discountValue => _discountValue;

  final Map<RxTemplate, String> _selectedConditions = {};
  Map<RxTemplate, String> get selectedConditions => _selectedConditions;

  TextEditingController discountFieldController = TextEditingController();

  List<RxTemplate> rxTemplate = [];

  List<MedicineDetailsModel> prescribedMedicines = [];

  MedicineDetailsModel newMedicine = MedicineDetailsModel();

  List<TextEditingController> _noteControllers = [];
  List<TextEditingController> get noteControllers => _noteControllers;

  set noteControllers(List<TextEditingController> value) {
    _noteControllers = value;
    notifyListeners();
  }

  DateTime? _nextDate;
  DateTime? get nextDate => _nextDate;

  set nextDate(DateTime? value) {
    _nextDate = value;
    notifyListeners();
  }

  set discountValue(int value) {
    _discountValue = value;
    notifyListeners();
  }

  set selectedGrade(String value) {
    _selectedGrade = value;
    notifyListeners();
  }

  void getConditions(BuildContext context) {
    rxTemplate.clear();
    rxTemplate.addAll(context.read<UserProvider>().user.settings!.rxTemplates);

    notifyListeners();
  }

  void initialiseMeds() {
    for (var element in selectedConditions.entries) {
      if (element.value == "Grade 1" && element.key.medication.isNotEmpty) {
        prescribedMedicines.addAll(element.key.medication[0].medicineDetails);
      } else if (element.value == "Grade 2" && element.key.medication.isNotEmpty) {
        prescribedMedicines.addAll(element.key.medication[1].medicineDetails);
      } else if (element.value == "Grade 3" && element.key.medication.length >= 2) {
        prescribedMedicines.addAll(element.key.medication[2].medicineDetails);
      }
    }

    noteControllers.addAll(
      List<TextEditingController>.generate(
        prescribedMedicines.length,
        (index) => TextEditingController(text: prescribedMedicines[index].message),
      ),
    );
    notifyListeners();
  }

  String checkConditionExist(RxTemplate condition) {
    if (_selectedConditions.containsKey(condition)) {
      return _selectedConditions[condition]!;
    } else {
      return "";
    }
  }

  void addCondition(RxTemplate condition, String grade) {
    if (_selectedConditions.containsKey(condition)) {
      if (_selectedConditions[condition] == grade) {
        _selectedConditions.remove(condition);
      } else {
        _selectedConditions[condition] = grade;
      }
    } else {
      _selectedConditions[condition] = grade;
    }
    notifyListeners();
  }

  void addNewMedicine({required MedicineDetailsModel newMed}) {
    prescribedMedicines.add(newMed);
    noteControllers.add(TextEditingController());
    notifyListeners();
  }

  void deleteMedicine(int index) {
    prescribedMedicines.removeAt(index);
    noteControllers.removeAt(index);
    notifyListeners();
  }

  void addIntakeDosage(String intakeConstant, int index) {
    if (prescribedMedicines[index].intakeDetails!.intake.contains(intakeConstant)) {
      prescribedMedicines[index].intakeDetails!.intake.remove(intakeConstant);
    } else {
      prescribedMedicines[index].intakeDetails!.intake.add(intakeConstant);
    }
  }

  void editMedicineIntake(int index) {
    if (prescribedMedicines[index].intakeDetails?.foodTime == "Before Food") {
      prescribedMedicines[index].intakeDetails?.foodTime = "After Food";
    } else {
      prescribedMedicines[index].intakeDetails?.foodTime = "Before Food";
    }
    log("Intake Details: ${prescribedMedicines[index].intakeDetails?.foodTime}");
    notifyListeners();
  }

  void editMedicineType(int index, String medicineType) {
    prescribedMedicines[index].medicineType = medicineType;
    notifyListeners();
  }

  Future<void> createRx({required RxModel params}) async {
    try {
      setLoading(true);
      await createRxUseCase.execute(params);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendRxToPatient({required SendToPatientParams params}) async {
    try {
      setLoading(true);
      await sendRxToPatientUsecase.execute(params);
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<String> _getOutputPath(String name, String phone) async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/${name}_$phone.pdf';
  }

  Future<File?> generate({
    required RxModel data,
    required Appointment appointment,
    required User user,
    String? logoUrl,
    String? signatureUrl,
    required bool showAge,
    required bool showHeight,
    required bool showWeight,
    required bool showBodyTemperature,
    required bool showBloodPressure,
    required bool showPulseRate,
    required bool showRespirationRate,
  }) async {
    try {
      setLoading(true);
      final pdf = Document();

      pw.ImageProvider? clinicLogoImageProvider;
      pw.ImageProvider? signatureImageProvider;
      pw.Image? logoImage;
      pw.Image? signatureImage;

      if (logoUrl != null) {
        clinicLogoImageProvider = await networkImage(logoUrl);
        logoImage = pw.Image(clinicLogoImageProvider, height: 56, width: 56);
      }

      if (signatureUrl != null) {
        signatureImageProvider = await networkImage(signatureUrl);
        signatureImage = pw.Image(signatureImageProvider, height: 56, width: 56);
      }

      log(signatureUrl.toString());

      final String additionalNote = data.additionalNotes!;
      final String doctorName = user.profile?.name ?? "-";
      final String doctorSpecialisation = user.profile?.specialization ?? "-";
      final String doctorEmail = user.profile?.email ?? "-";
      final String footerMessage = user.settings?.rxFormat?.footerInfo?.message ?? "-";
      final String doctorPhone = "${user.profile?.phone?.countryCode} ${user.profile?.phone?.phoneNumber}";
      final String doctorAddress = user.profile?.address ?? "-";

      log("$doctorName $doctorEmail $doctorPhone $doctorAddress");

      pdf.addPage(
        MultiPage(
          build: (pw.Context context) {
            return [
              RxPDF.buildHeader(
                image: logoImage,
                doctorName: doctorName,
                doctorEmail: doctorEmail,
                doctorPhone: doctorPhone,
                doctorAddress: doctorAddress,
                specialisation: doctorSpecialisation,
                rxFormat: user.settings?.rxFormat,
              ),
              RxPDF.buildPatientDetails(
                showAge: showAge,
                showHeight: showHeight,
                showWeight: showWeight,
                appointment: appointment,
                showPulseRate: showPulseRate,
                patient: data.patientBasicDetail!,
                showBloodPressure: showBloodPressure,
                showBodyTemperature: showBodyTemperature,
                showRespirationRate: showRespirationRate,
              ),
              RxPDF.buildHeading("Symptoms"),
              RxPDF.buildSymptoms(data.symptoms),
              RxPDF.buildDivider(),
              RxPDF.buildHeading("Diagnosis"),
              RxPDF.buildDiagnosisList(data.diagnosis),
              RxPDF.buildDivider(),
              RxPDF.buildHeading("Medications"),
              RxPDF.buildMedicationsTableHeadings(),
              RxPDF.buildMedicationList(data.medication),
              RxPDF.buildDivider(),
              RxPDF.buildHeading("Additional Notes"),
              RxPDF.buildAdditionalNotes(content: additionalNote),
              RxPDF.buildDivider(),
              RxPDF.buildFooter(
                footerMessage: footerMessage,
                signatureImage: signatureImage,
              ),
            ];
          },
        ),
      );

      final output = await _getOutputPath(
        data.patientBasicDetail?.name ?? "patientName",
        data.patientBasicDetail?.phone ?? "patientNumber",
      );
      final file = File(output);
      file.writeAsBytesSync(await pdf.save());
      return file;
    } catch (e) {
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
