
import 'package:aasa_emr/features/rx_screen/presentation/providers/rx_provider.dart';
import 'package:provider/provider.dart';

import '../constants/intake_constants.dart';
import '../../features/user/data/models/settings_model.dart';

import '../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class DosageWidget extends StatelessWidget {
  const DosageWidget({
    super.key,
    required this.index,
    required this.intakeDetails,
    this.setMorning,
    this.setNoon,
    this.setNight,
  });

  final int index;
  final IntakeDetailsModel? intakeDetails;
  final Function(bool?)? setMorning;
  final Function(bool?)? setNoon;
  final Function(bool?)? setNight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 16.w, child: const Divider(thickness: 2, color: ConstantColors.kSecondaryColor)),
        RoundCheckBox(
          size: 32.r,
          checkedWidget: const SizedBox(),
          checkedColor: ConstantColors.kSecondaryColor,
          isChecked: intakeDetails!.intake.contains(IntakeConstants.morning),
          onTap: setMorning ??
              (newValue) {
                context.read<RxProvider>().addIntakeDosage(IntakeConstants.morning, index);
              },
        ),
        SizedBox(width: 16.w, child: const Divider(thickness: 2, color: ConstantColors.kSecondaryColor)),
        RoundCheckBox(
          size: 32.r,
          checkedWidget: const SizedBox(),
          checkedColor: ConstantColors.kSecondaryColor,
          isChecked: intakeDetails!.intake.contains(IntakeConstants.noon),
          onTap: setNoon ??
              (newValue) {
                context.read<RxProvider>().addIntakeDosage(IntakeConstants.noon, index);
              },
        ),
        SizedBox(width: 16.w, child: const Divider(thickness: 2, color: ConstantColors.kSecondaryColor)),
        RoundCheckBox(
          size: 32.r,
          checkedWidget: const SizedBox(),
          checkedColor: ConstantColors.kSecondaryColor,
          isChecked: intakeDetails!.intake.contains(IntakeConstants.night),
          onTap: setNight ??
              (newValue) {
                context.read<RxProvider>().addIntakeDosage(IntakeConstants.night, index);
              },
        ),
        SizedBox(width: 16.w, child: const Divider(thickness: 2, color: ConstantColors.kSecondaryColor)),
      ],
    );
  }
}
