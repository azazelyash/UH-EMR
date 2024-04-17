import '../../../data/models/appointment.dart';

import 'upcomming_child_closed_widget.dart';
import 'upcomming_child_open_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcommingAppointmentTile extends StatelessWidget {
  const UpcommingAppointmentTile({
    super.key,
    required this.index,
    required this.appointment,
    required this.isSelected,
  });

  final int index;
  // final String name;
  // final String date;
  // final String time;
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
        secondChild: UpcommingTileOpenWidget(
          appointment: appointment,
        ),
        firstChild: UpcommingChildClosedWidget(
          appointment: appointment,
        ),
      ),
    );
  }
}
