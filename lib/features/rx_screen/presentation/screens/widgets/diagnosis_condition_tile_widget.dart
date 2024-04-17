import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import 'condition_grade_chip.dart';

class DiagnosisConditionTileWidget extends StatelessWidget {
  const DiagnosisConditionTileWidget({
    super.key,
    required this.grade,
    required this.condition,
    required this.index,
  });

  final int index;
  final String grade;
  final RxTemplate condition;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ConstantColors.kTileBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              (index + 1).toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              condition.condition!.conditionName!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: ConditionGradeChip(grade: grade),
          ),
        ],
      ),
    );
  }
}
