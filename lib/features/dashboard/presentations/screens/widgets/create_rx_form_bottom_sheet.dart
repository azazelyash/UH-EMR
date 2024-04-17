import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/rx_screen/presentation/screens/patient_rx_screen.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../common/constants/dummy_symptoms_data.dart';
import '../../../../../utils/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../common/helper/date_time_parser.dart';
import '../../../../../common/helper/phone_number_parser.dart';
import '../../../../../common/helper/utils.dart';
import '../../../../../common/widgets/back_chevron_button.dart';
import '../../../../../common/widgets/expanded_elevated_button.dart';
import '../../../../../utils/constants/strings.dart';
import '../../../../../utils/validators/validators.dart';
import '../../../../user/presentation/providers/user_provider.dart';
import '../../../data/models/patients.dart';
import '../../providers/appointment_provider.dart';
import '../../providers/dashboard_provider.dart';

class CreateRxFormBottomSheet extends StatefulWidget {
  const CreateRxFormBottomSheet({
    super.key,
  });

  @override
  State<CreateRxFormBottomSheet> createState() => _CreateRxFormBottomSheetState();
}

class _CreateRxFormBottomSheetState extends State<CreateRxFormBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dobContoller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyTempController = TextEditingController();
  TextEditingController respRateController = TextEditingController();
  TextEditingController pulseRateController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();

  String countryCode = "+91";

  DateTime schedule = DateTime.now();
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schedule = DateTime.now();
    dateController.text = DateFormat.yMMMd().format(DateTime.now());
    timeController.text = DateFormat.jmz().format(DateTime.now());
    // final dashboardProvider = context.read<DashboardProvider>();
    // if (dashboardProvider.startConsulationNow) {
    //   schedule = DateTime.now();
    //   dateController.text = DateFormat.yMMMd().format(DateTime.now());
    //   timeController.text = DateFormat.jmz().format(DateTime.now());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            color: ConstantColors.kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (context.watch<DashboardProvider>().createNewPatient)
                        ? Strings.newPatient
                        : Strings.existingPatient,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  BackChevronButton(
                    onTap: () {
                      dobContoller.clear();
                      timeController.clear();
                      dateController.clear();
                      emailContoller.clear();
                      nameController.clear();
                      context.read<DashboardProvider>().fillDetailsState = false;
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              (context.watch<DashboardProvider>().createNewPatient)
                  ? Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: Validators.requiredValidator,
                            decoration: const InputDecoration(
                              label: Text("Patient Name"),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: emailContoller,
                            validator: Validators.emailValidator,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(r"\s\b|\b\s"),
                              ),
                            ],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              label: Text("Patient Email"),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          IntlPhoneField(
                            showCountryFlag: false,
                            initialCountryCode: 'IN',
                            disableLengthCheck: false,
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            dropdownIconPosition: IconPosition.trailing,
                            flagsButtonPadding: EdgeInsets.only(left: 12.w),
                            dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            languageCode: "en",
                            onCountryChanged: (value) {
                              countryCode = value.dialCode;
                            },
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            showCursor: false,
                            controller: dobContoller,
                            keyboardType: TextInputType.none,
                            enableInteractiveSelection: false,
                            validator: Validators.requiredValidator,
                            onTap: () async {
                              final value = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1899),
                                lastDate: DateTime.now(),
                              );
                              if (value != null) {
                                dobContoller.text = DateTimeParser.fetchDateFromUtc(value);
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              label: Text("Date of Birth"),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Name",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Date of Birth",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  (context.read<AppointmentProvider>().selectedPatient != null)
                                      ? context.read<AppointmentProvider>().selectedPatient!.name!
                                      : "Patient Name",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  (context.read<AppointmentProvider>().selectedPatient != null)
                                      ? DateTimeParser.fetchDateFromUtc(
                                          context.read<AppointmentProvider>().selectedPatient!.dob!)
                                      : "DOB",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Contact Number",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  "Email",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    (context.read<AppointmentProvider>().selectedPatient != null)
                                        ? PhoneNumberParser.getPhoneString(
                                            context.read<AppointmentProvider>().selectedPatient!.phone!)
                                        : "Phone",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      (context.read<AppointmentProvider>().selectedPatient != null)
                                          ? context.read<AppointmentProvider>().selectedPatient!.email!
                                          : "-",
                                      style: Theme.of(context).textTheme.titleMedium,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
              SizedBox(height: 12.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: dateController,
                      enabled: !context.read<DashboardProvider>().startConsulationNow,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.none,
                      textInputAction: TextInputAction.next,
                      showCursor: false,
                      onTap: () async {
                        final value = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 700)),
                          firstDate: DateTime.now(),
                        );
                        if (value != null) {
                          schedule = value;
                          dateController.text = DateFormat.yMMMd().format(value);
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text("Enter Date"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextFormField(
                      controller: timeController,
                      enabled: !context.read<DashboardProvider>().startConsulationNow,
                      keyboardType: TextInputType.none,
                      enableInteractiveSelection: false,
                      textInputAction: TextInputAction.next,
                      showCursor: false,
                      onTap: () async {
                        final value = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (value != null) {
                          schedule = DateTime(schedule.year, schedule.month, schedule.day, value.hour, value.minute);
                          timeController.text = DateFormat.jmv().format(DateTime(0, 0, 0, value.hour, value.minute));
                        }
                      },
                      decoration: const InputDecoration(
                        label: Text("Enter Time"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              DropdownButtonFormField(
                hint: const Text("Select Clinic"),
                value: context.read<UserProvider>().clinics.first.id,
                items: context
                    .read<UserProvider>()
                    .clinics
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name ?? "-"),
                      ),
                    )
                    .toList(),
                onChanged: (value) {},
              ),
              (context.read<DashboardProvider>().startConsulationNow)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.height ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: heightController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Height"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.weight ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: weightController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Weight"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.age ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: ageController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Age"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.bodyTemperature ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: bodyTempController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Body Temperature"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.bloodPressure ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: bloodPressureController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Blood Pressure"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.respirationRate ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: respRateController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Respiration Rate"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.pulseRate ?? false)
                            ? Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: TextFormField(
                                  controller: pulseRateController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    label: Text("Patient Pulse Rate"),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 12.h),
                        MultiSelectChipField(
                          showHeader: false,
                          scroll: false,
                          decoration: const BoxDecoration(),
                          initialValue: context.watch<DashboardProvider>().selectedSymptoms!,
                          onTap: (newSymptomsList) {
                            context.read<DashboardProvider>().selectedSymptoms = newSymptomsList;
                          },
                          items: symptomsData.map(
                            (e) {
                              return MultiSelectItem<String?>(e, e);
                            },
                          ).toList(),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(height: 12.h),
              ExpandedElevatedButton(
                title: "Continue",
                onTap: () async {
                  try {
                    final date = schedule;
                    String doctorId;
                    final patientVitalsProvider = context.read<UserProvider>().user.settings?.rxFormat?.patientVitals;

                    if (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor) {
                      doctorId = context.read<UserProvider>().user.id!;
                    } else {
                      doctorId = context.read<UserProvider>().selectedDoctor!.id!;
                    }

                    PatientVital? patientVitals = PatientVital();

                    (patientVitalsProvider?.age ?? false) ? patientVitals.age = ageController.text.trim() : null;
                    (patientVitalsProvider?.height ?? false)
                        ? patientVitals.height = heightController.text.trim()
                        : null;
                    (patientVitalsProvider?.weight ?? false)
                        ? patientVitals.weight = weightController.text.trim()
                        : null;
                    (patientVitalsProvider?.pulseRate ?? false)
                        ? patientVitals.pulseRate = pulseRateController.text.trim()
                        : null;
                    (patientVitalsProvider?.bodyTemperature ?? false)
                        ? patientVitals.bodyTemperature = bodyTempController.text.trim()
                        : null;
                    (patientVitalsProvider?.respirationRate ?? false)
                        ? patientVitals.respirationRate = respRateController.text.trim()
                        : null;
                    (patientVitalsProvider?.bloodPressure ?? false)
                        ? patientVitals.bloodPressure = bloodPressureController.text.trim()
                        : null;

                    if (context.read<DashboardProvider>().createNewPatient) {
                      if (!_formKey.currentState!.validate()) return;

                      Patient patient = Patient();

                      patient.name = nameController.value.text;
                      patient.email = emailContoller.value.text;
                      patient.phone = Phone(phoneNumber: phoneController.text, countryCode: countryCode);
                      patient.dob = DateTimeParser.parseCustomDate(dobContoller.value.text);
                      patient.patientVitals = patientVitals;
                      patient.doctorIDs = [doctorId];
                      await context.read<AppointmentProvider>().createPatient(patient: patient);
                    }

                    if (!mounted) return;

                    DoctorModel userDoctor = DoctorModel(
                      id: doctorId,
                      doctorProfile: DoctorProfileModel(
                        name: context.read<UserProvider>().user.profile?.name,
                      ),
                    );

                    context.read<AppointmentProvider>().updateSelectedPatientVitals(patientVitals);

                    Appointment appointmentModel = Appointment(
                      dateTime: date,
                      userDoctor: userDoctor,
                      userPatient: context.read<AppointmentProvider>().selectedPatient,
                      clinic: context.read<UserProvider>().selectedClinics[0].id!,
                    );
                    // log(appointmentModel.toJson().toString());

                    Appointment appointment =
                        await context.read<AppointmentProvider>().createAppointment(appointmentModel);
                    List<String?>? selectedSymptoms = context.read<DashboardProvider>().selectedSymptoms;

                    if (!mounted) return;
                    if (context.read<DashboardProvider>().startConsulationNow) {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => PatientRxScreen(
                            appointment: appointment,
                            selectedSymptoms: selectedSymptoms,
                            patient: context.read<AppointmentProvider>().selectedPatient!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    if (!mounted) return;
                    Utils.showSnackBar(
                      context,
                      content: e.toString(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
