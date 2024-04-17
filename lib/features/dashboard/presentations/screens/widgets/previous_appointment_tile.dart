import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/previous_appointment_tile_closed.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/previous_appointment_tile_opened.dart';

import '../../../data/models/appointment.dart';

import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviousAppointmentTile extends StatelessWidget {
  const PreviousAppointmentTile({
    super.key,
    required this.index,
    required this.appointment,
    required this.isSelected,
  });

  final int index;
  final Appointment appointment;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ConstantColors.kTileBackgroundColor,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        firstCurve: Curves.easeOut,
        secondCurve: Curves.easeIn,
        sizeCurve: Curves.easeInOut,
        crossFadeState: (isSelected) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        secondChild: PreviousAppointmentTileOpened(
          appointment: appointment,
        ),
        firstChild: PreviousAppointmentTileClosed(
          appointment: appointment,
        ),
      ),
    );
  }
}
