import 'dart:developer';

import '../../../../user/data/models/settings_model.dart';

import '../../providers/rx_provider.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConditionTileWidget extends StatelessWidget {
  const ConditionTileWidget({
    super.key,
    required this.condition,
    required this.conditionName,
    required this.gradeOneValue,
    required this.gradeTwoValue,
    required this.gradeThreeValue,
  });

  final RxTemplate condition;
  final String gradeOneValue;
  final String gradeTwoValue;
  final String gradeThreeValue;
  final String conditionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ConstantColors.kTileBackgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              conditionName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          ),
          Expanded(
            flex: 1,
            child: Transform.scale(
              scale: 1.4,
              child: Radio<String>(
                splashRadius: 16,
                toggleable: true,
                value: gradeOneValue,
                activeColor: ConstantColors.kSecondaryColor,
                groupValue: context.read<RxProvider>().checkConditionExist(condition),
                onChanged: (radValue) {
                  log(radValue.toString());
                  context.read<RxProvider>().addCondition(condition, gradeOneValue);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Transform.scale(
              scale: 1.4,
              child: Radio<String>(
                splashRadius: 16,
                toggleable: true,
                value: gradeTwoValue,
                activeColor: ConstantColors.kSecondaryColor,
                groupValue: context.read<RxProvider>().checkConditionExist(condition),
                onChanged: (radValue) {
                  log(radValue.toString());
                  context.read<RxProvider>().addCondition(condition, gradeTwoValue);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Transform.scale(
              scale: 1.4,
              child: Radio<String>(
                toggleable: true,
                splashRadius: 16,
                value: gradeThreeValue,
                activeColor: ConstantColors.kSecondaryColor,
                groupValue: context.read<RxProvider>().checkConditionExist(condition),
                onChanged: (radValue) {
                  log(radValue.toString());
                  context.read<RxProvider>().addCondition(condition, gradeThreeValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
