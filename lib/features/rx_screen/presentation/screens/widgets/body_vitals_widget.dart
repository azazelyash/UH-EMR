import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../common/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../dashboard/data/models/patients.dart';

class BodyVitalsWidget extends StatelessWidget {
  const BodyVitalsWidget({
    super.key,
    required this.patient,
    this.visit,
  });

  final Patient patient;
  final String? visit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  const Text("Patient Name:"),
                  SizedBox(width: 8.w),
                  Text(
                    patient.name ?? "-",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Visit:"),
                  SizedBox(width: 8.w),
                  Text(
                    visit ?? "-",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
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
                        (patient.dob != null) ? AppFunctions.calculatePatientAge(patient.dob!).toString().split(" ").first : "-",
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
                        (patient.patientVitals?.weight != null && patient.patientVitals?.weight != "") ? patient.patientVitals!.weight! : "-",
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
                        (patient.patientVitals?.height != null && patient.patientVitals?.height != "") ? patient.patientVitals!.height! : "-",
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
                        (patient.patientVitals?.bodyTemperature != null && patient.patientVitals?.bodyTemperature != "") ? patient.patientVitals!.bodyTemperature! : "-",
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
                        (patient.patientVitals?.bloodPressure != null && patient.patientVitals?.bloodPressure != "") ? patient.patientVitals!.bloodPressure! : "-",
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
                        (patient.patientVitals?.respirationRate != null && patient.patientVitals?.respirationRate != "") ? patient.patientVitals!.respirationRate! : "-",
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
                        (patient.patientVitals?.pulseRate != null && patient.patientVitals?.pulseRate != "") ? patient.patientVitals!.pulseRate! : "-",
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
