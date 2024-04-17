import 'package:aasa_emr/features/dashboard/data/models/patients.dart';

import '../../../data/models/appointment.dart';
import 'package:intl/intl.dart';

import '../../../../../common/constants/dummy_symptoms_data.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../../common/widgets/expanded_elevated_button.dart';
import '../../../../rx_screen/presentation/screens/patient_rx_screen.dart';
import '../../../../user/presentation/providers/user_provider.dart';
import '../../providers/dashboard_provider.dart';

class StartInstantRxBottomSheet extends StatefulWidget {
  const StartInstantRxBottomSheet({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<StartInstantRxBottomSheet> createState() => _StartInstantRxBottomSheetState();
}

class _StartInstantRxBottomSheetState extends State<StartInstantRxBottomSheet> {
  DateTime? selectedDateTime;
  late String selectedClinicId;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyTempController = TextEditingController();
  TextEditingController respRateController = TextEditingController();
  TextEditingController pulseRateController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();

  @override
  void initState() {
    dateController.text = DateFormat.yMMMd().format(widget.appointment.dateTime!);
    timeController.text = DateFormat.jmz().format(widget.appointment.dateTime!);
    selectedClinicId = context.read<UserProvider>().selectedClinics.first.id!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: ConstantColors.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Existing Patient",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Material(
                color: Colors.white,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Column(
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
                        widget.appointment.userPatient?.name ?? "-",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        widget.appointment.userPatient?.dob != null ? DateFormat.yMMMd().format(widget.appointment.userPatient!.dob!) : "-",
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
                          widget.appointment.userPatient?.phone?.phoneNumber ?? "-",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.appointment.userPatient?.email ?? "-",
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
                  enabled: false,
                  controller: dateController,
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.none,
                  textInputAction: TextInputAction.next,
                  showCursor: false,
                  onTap: () async {
                    // final value = await showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   lastDate: DateTime.now().add(const Duration(days: 700)),
                    //   firstDate: DateTime.now(),
                    // );
                    // if (value != null) {
                    //   dateController.text = DateFormat.yMMMd().format(value);
                    // }
                  },
                  decoration: const InputDecoration(
                    label: Text("Enter Date"),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextFormField(
                  enabled: false,
                  controller: timeController,
                  keyboardType: TextInputType.none,
                  enableInteractiveSelection: false,
                  textInputAction: TextInputAction.next,
                  showCursor: false,
                  onTap: () async {
                    // final value = await showTimePicker(
                    //   context: context,
                    //   initialTime: TimeOfDay.now(),
                    // );
                    // if (value != null) {
                    //   timeController.text = DateTimeParser.formatTime(value);
                    // }
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
            value: context.read<UserProvider>().selectedClinics.first.id,
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
            onChanged: (value) {
              log(value.toString());
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.height!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: heightController,
                        decoration: const InputDecoration(
                          label: Text("Patient Height"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.weight!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: weightController,
                        decoration: const InputDecoration(
                          label: Text("Patient Weight"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.age!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          label: Text("Patient Age"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.bodyTemperature!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: bodyTempController,
                        decoration: const InputDecoration(
                          label: Text("Patient Body Temperature"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.bloodPressure!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: bloodPressureController,
                        decoration: const InputDecoration(
                          label: Text("Patient Blood Pressure"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.respirationRate!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: respRateController,
                        decoration: const InputDecoration(
                          label: Text("Patient Respiration Rate"),
                        ),
                      ),
                    )
                  : const SizedBox(),
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.pulseRate!)
                  ? Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: TextFormField(
                        controller: pulseRateController,
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
          ),
          SizedBox(height: 12.h),
          ExpandedElevatedButton(
            title: "Continue",
            onTap: () {
              PatientVital? patientVitals = PatientVital();

              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.age!) ? patientVitals.age = ageController.text.trim() : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.height!) ? patientVitals.height = heightController.text.trim() : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.weight!) ? patientVitals.weight = weightController.text : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.pulseRate!) ? patientVitals.pulseRate = pulseRateController.text.trim() : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.bodyTemperature!) ? patientVitals.bodyTemperature = bodyTempController.text.trim() : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.respirationRate!) ? patientVitals.respirationRate = respRateController.text.trim() : null;
              (context.read<UserProvider>().user.settings!.rxFormat!.patientVitals!.bloodPressure!) ? patientVitals.bloodPressure = bloodPressureController.text.trim() : null;

              widget.appointment.userPatient!.patientVitals = patientVitals;

              List<String?>? selectedSymptoms = context.read<DashboardProvider>().selectedSymptoms;

              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => PatientRxScreen(
                    appointment: widget.appointment,
                    selectedSymptoms: selectedSymptoms,
                    patient: widget.appointment.userPatient!,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
