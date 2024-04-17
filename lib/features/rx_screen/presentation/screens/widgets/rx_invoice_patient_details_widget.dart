import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aasa_emr/common/functions/functions.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';

class RxInvoicePatientDetails extends StatelessWidget {
  const RxInvoicePatientDetails({
    super.key,
    required this.appointment,
    required this.selectedSymptoms,
    required this.patientBasicDetail,
  });

  final Appointment? appointment;
  final List<String?>? selectedSymptoms;
  final PatientBasicDetail? patientBasicDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Text(
                "Patient Name",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Expanded(
              child: Text(
                "Visit",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: Text(
                appointment?.userPatient?.name ?? "-",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: Text(
                appointment?.visit ?? "-",
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 10.h),
        Text(
          "Symptoms",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 4.h),
        (selectedSymptoms != null) ? Text(selectedSymptoms!.join(",  ")) : const Text("No symptoms selected"),
        SizedBox(height: 10.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 10.h),
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
                      (appointment?.userPatient?.dob != null) ? AppFunctions.calculatePatientAge(appointment!.userPatient!.dob!).toString().split(" ").first : "-",
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
                      (patientBasicDetail?.weight != null && patientBasicDetail?.weight != "") ? patientBasicDetail!.weight! : "-",
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
                      (patientBasicDetail?.height != null && patientBasicDetail?.height != "") ? patientBasicDetail!.height! : "-",
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
                      (patientBasicDetail?.bodyTemperature != null && patientBasicDetail?.bodyTemperature != "") ? patientBasicDetail!.bodyTemperature! : "-",
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
                      (patientBasicDetail?.bloodPressure != null && patientBasicDetail?.bloodPressure != "") ? patientBasicDetail!.bloodPressure! : "-",
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
                      (patientBasicDetail?.respirationRate != null && patientBasicDetail?.respirationRate != "") ? patientBasicDetail!.respirationRate! : "-",
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
                      (patientBasicDetail?.pulseRate != null && patientBasicDetail?.pulseRate != "") ? patientBasicDetail!.pulseRate! : "-",
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        SizedBox(height: 12.h),
        const DottedDashedLine(
          height: 1,
          width: double.infinity,
          axis: Axis.horizontal,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
