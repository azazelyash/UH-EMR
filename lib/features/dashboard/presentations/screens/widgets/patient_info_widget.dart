import 'package:aasa_emr/features/dashboard/data/models/patients.dart';

import '../edit_patient_info_screen.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientInfoWidget extends StatelessWidget {
  const PatientInfoWidget({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  Strings.patientDetails,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              // Expanded(
              //   child: FittedBox(
              //     child: Text(
              //       "Patient ID: ${patient.id}",
              //       textAlign: TextAlign.end,
              //       style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ConstantColors.kSecondaryColor),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 6.h),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Name"),
              Text("Contact"),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  patient.name!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  "${patient.phone!.countryCode!} ${patient.phone!.phoneNumber!}",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
          SizedBox(height: 6.h),
          const Text("Address"),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  patient.address ?? "-",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => EditPatientInfoScreen(
                          patient: patient,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit_rounded,
                    size: 16,
                  ),
                  label: Text(Strings.edit),
                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
