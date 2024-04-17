import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/colors.dart';

class NoteFromDoctorWidget extends StatelessWidget {
  const NoteFromDoctorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffE9FDF3),
        border: Border.all(color: ConstantColors.kSecondaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Note from Doctor",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            "After reviewing Mr. Johnson's recent lab results and discussing his symptoms, we've adjusted his medication dosage to better manage his blood pressure and cholesterol levels. Additionally, we've scheduled a follow-up appointment in two weeks to monitor his progress and discuss any further adjustments to his treatment plan. In the meantime, I've advised him to continue his current lifestyle modifications, including regular exercise and a heart-healthy diet. We'll continue to closely monitor his health and address any concerns as they arise.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
