import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../common/functions/functions.dart';
import '../../../../common/widgets/add_medicine_dialog_widget.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../common/widgets/medicines_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import '../../../dashboard/data/models/appointment.dart';
import '../../../dashboard/data/models/patients.dart';
import '../../../dashboard/data/models/rx_model.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../providers/rx_provider.dart';
import 'preview_rx_screen.dart';
import 'widgets/diagnosis_details_widget.dart';
import 'widgets/patient_details_widget.dart';

class DraftRxScreen extends StatefulWidget {
  final Patient patient;
  final List<String?>? selectedSymptoms;

  final Appointment appointment;
  const DraftRxScreen({
    super.key,
    required this.patient,
    required this.appointment,
    required this.selectedSymptoms,
  });

  @override
  State<DraftRxScreen> createState() => _DraftRxScreenState();
}

class _DraftRxScreenState extends State<DraftRxScreen> {
  TextEditingController additionalNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<RxProvider>(
            builder: (context, rxProvider, child) {
              return Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0),
                    child: CustomAppBarWithBackButton(),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          Strings.draftRx,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          DateFormat.yMMMd().format(widget.appointment.dateTime!),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: PatientDetailsWidget(
                      patient: widget.patient,
                      visit: widget.appointment.visit,
                      selectedSymptoms: widget.selectedSymptoms,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DiagnosisDetailWidget(),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Text(
                            Strings.medicines,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              var newMedicine = await showDialog(
                                context: context,
                                builder: (context) => const AddMedicineDialogWidget(),
                              );

                              if (newMedicine != null) {
                                rxProvider.addNewMedicine(newMed: newMedicine);
                              }
                            },
                            icon: const Icon(
                              Icons.add_rounded,
                              size: 20,
                            ),
                            label: Text(Strings.add),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ConstantColors.kSecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rxProvider.prescribedMedicines.length,
                    itemBuilder: (context, index) {
                      return MedicinesTileWidget(
                        index: index,
                        onChanged: (value) {
                          rxProvider.editMedicineIntake(index);
                        },
                        onChangeMedicineType: (medicineType) {
                          rxProvider.editMedicineType(index, medicineType);
                        },
                        noteController: rxProvider.noteControllers[index],
                        medicineDetails: rxProvider.prescribedMedicines[index],
                      );
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         flex: 5,
                  //         child: Text(
                  //           Strings.tests,
                  //           style: Theme.of(context).textTheme.headlineSmall,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 2,
                  //         child: ElevatedButton.icon(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.add_rounded,
                  //             size: 20,
                  //           ),
                  //           label: Text(Strings.add),
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: ConstantColors.kSecondaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 12.h),
                  // ListView.builder(
                  //   itemCount: rxProvider.rxTemplate.length,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return TestsTileWidget(items: items);
                  //   },
                  // ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      minLines: 2,
                      maxLines: null,
                      controller: additionalNotesController,
                      decoration: InputDecoration(
                        hintText: Strings.addNote,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ConstantColors.kWhiteColor,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: ConstantColors.kSecondaryColor),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      Strings.nextDate,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: (context.watch<RxProvider>().nextDate == null)
                          ? GestureDetector(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 700),
                                  ),
                                );

                                if (!mounted) return;

                                final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now().add(
                                      const Duration(hours: 1),
                                    ),
                                  ),
                                );

                                if (!mounted) return;
                                if (date != null && time != null) {
                                  context.read<RxProvider>().nextDate =
                                      DateTime(date.year, date.month, date.day, time.hour, time.minute);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Strings.setDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: ConstantColors.kSecondaryColor),
                                  ),
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 18,
                                    color: ConstantColors.kSecondaryColor,
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                context.read<RxProvider>().nextDate = null;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(context.watch<RxProvider>().nextDate!.toLocal().toString().split(" ").first),
                                  const Icon(
                                    Icons.close,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () async {
                  Analytics.logPreviewAndSign();
                  String doctorId = context.read<UserProvider>().user.id!;

                  PatientBasicDetail patientBasicDetail = PatientBasicDetail(
                    name: widget.patient.name,
                    email: widget.patient.email,
                    age: AppFunctions.calculatePatientAge(widget.patient.dob!).toString(),
                    phone: widget.patient.phone!.phoneNumber,
                    bodyTemperature: widget.patient.patientVitals?.bodyTemperature,
                    bloodPressure: widget.patient.patientVitals?.bloodPressure,
                    height: widget.patient.patientVitals?.height,
                    weight: widget.patient.patientVitals?.weight,
                    pulseRate: widget.patient.patientVitals?.pulseRate,
                    respirationRate: widget.patient.patientVitals?.respirationRate,
                  );

                  List<Medication> medicines = [];

                  for (int i = 0; i < context.read<RxProvider>().prescribedMedicines.length; i++) {
                    final val = context.read<RxProvider>().prescribedMedicines[i];
                    Medication medication = Medication(
                      medicine: val.medicineName,
                      days: val.intakeDetails?.days,
                      medicineType: val.medicineType,
                      intake: val.intakeDetails?.intake,
                      frequency: val.intakeDetails?.amount,
                      foodTime: val.intakeDetails?.foodTime,
                      note: context.read<RxProvider>().noteControllers[i].text,
                    );
                    medicines.add(medication);
                  }

                  List<Diagnosis> diagnosis = [];
                  context.read<RxProvider>().selectedConditions.forEach((key, value) {
                    diagnosis.add(
                      Diagnosis(
                        condition: Condition(conditionName: key.condition?.conditionName, id: key.condition?.id),
                        grade: Grade(gradeName: value),
                      ),
                    );
                  });

                  RxModel data = RxModel(
                    doctorId: doctorId,
                    diagnosis: diagnosis,
                    medication: medicines,
                    patientId: widget.patient.id,
                    symptoms: widget.selectedSymptoms,
                    appointmentId: widget.appointment.id,
                    patientBasicDetail: patientBasicDetail,
                    nextVisit: context.read<RxProvider>().nextDate,
                    additionalNotes: additionalNotesController.text,
                  );

                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => PreviewRxScreen(
                        rxModel: data,
                        appointment: widget.appointment,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.kSecondaryColor,
                ),
                child: Text(Strings.previewAndSign),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
