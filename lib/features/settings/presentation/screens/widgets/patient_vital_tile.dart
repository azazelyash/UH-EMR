// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aasa_emr/features/settings/presentation/providers/patient_vitals_provider.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PatientVitalFieldTile extends StatefulWidget {
  const PatientVitalFieldTile({
    Key? key,
    required this.vitalName,
    required this.isCheckBoxSelected,
    required this.onCheckboxSelected,
  }) : super(key: key);

  final String vitalName;
  final bool isCheckBoxSelected;
  final void Function(bool? value) onCheckboxSelected;

  @override
  State<PatientVitalFieldTile> createState() => _PatientVitalFieldTileState();
}

class _PatientVitalFieldTileState extends State<PatientVitalFieldTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientVitalsProvider>(builder: (context, patientVitalsProvider, child) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: ConstantColors.kTileBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 32,
                child: Text(widget.vitalName),
                // CustomDropdownWidget(
                //   items: patientVitalsProvider.allPatientVitals,
                //   value: patientVitalsProvider.selectedVital,
                //   onChanged: patientVitalsProvider.onChanged,
                //   borderSide: const BorderSide(color: Colors.black45),
                //   fillColor: ConstantColors.kWhiteColor,
                //   iconColor: Colors.black54,
                //   textColor: Colors.black54,
                // ),
              ),
            ),
            Expanded(
              child: Checkbox(
                value: widget.isCheckBoxSelected,
                onChanged: widget.onCheckboxSelected,
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.close),
            //   visualDensity: VisualDensity.compact,
            //   onPressed: () {},
            //   padding: EdgeInsets.zero,
            // ),
          ],
        ),
      );
    });
  }
}
