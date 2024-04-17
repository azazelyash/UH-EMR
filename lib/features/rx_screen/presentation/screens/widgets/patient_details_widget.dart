import 'package:aasa_emr/common/functions/functions.dart';
import 'package:aasa_emr/features/dashboard/data/models/patients.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class PatientDetailsWidget extends StatelessWidget {
  const PatientDetailsWidget({
    super.key,
    required this.patient,
    required this.visit,
    this.selectedSymptoms,
  });

  final Patient patient;
  final String? visit;
  final List<String?>? selectedSymptoms;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                Strings.patientDetails,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "${Strings.visit} $visit",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: ConstantColors.kSecondaryColor,
                    ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Patient Name"),
              Text("Contact"),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  patient.name ?? "-",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "${patient.phone!.countryCode} ${patient.phone!.phoneNumber}",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
          SizedBox(height: 6.h),
          const Divider(),
          SizedBox(height: 6.h),
          Text(
            "Symptoms",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 6.h),
          (selectedSymptoms != null) ? Text(selectedSymptoms!.join(",  ")) : const Text("No Symptoms Selected"),
          SizedBox(height: 6.h),
          const Divider(),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Vital",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                "Value",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.age ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Age",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.dob != null)
                            ? AppFunctions.calculatePatientAge(patient.dob!).toString().split(" ").first
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.weight ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Weight",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.weight != null && patient.patientVitals?.weight != "")
                            ? patient.patientVitals!.weight!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.height ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Height",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.height != null && patient.patientVitals?.height != "")
                            ? patient.patientVitals!.height!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.bodyTemperature ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Body Temperature",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.bodyTemperature != null && patient.patientVitals?.bodyTemperature != "")
                            ? patient.patientVitals!.bodyTemperature!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.bloodPressure ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Blood Pressure",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.bloodPressure != null && patient.patientVitals?.bloodPressure != "")
                            ? patient.patientVitals!.bloodPressure!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.respirationRate ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Respiration Rate",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.respirationRate != null && patient.patientVitals?.respirationRate != "")
                            ? patient.patientVitals!.respirationRate!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          (context.read<UserProvider>().user.settings?.rxFormat?.patientVitals?.pulseRate ?? false)
              ? Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pulse Rate",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        (patient.patientVitals?.pulseRate != null && patient.patientVitals?.pulseRate != "")
                            ? patient.patientVitals!.pulseRate!
                            : "-",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
