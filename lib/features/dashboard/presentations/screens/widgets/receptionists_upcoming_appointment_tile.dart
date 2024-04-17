import '../../../../../common/constants/dummy_list_of_doctors.dart';
import 'receptionists_upcoming_appointment_collapsed_tile.dart';
import 'receptionists_upcoming_appointment_expanded_tile.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceptionistsUpcommingAppointmentTile extends StatelessWidget {
  const ReceptionistsUpcommingAppointmentTile({
    super.key,
    required this.index,
    required this.name,
    required this.date,
    required this.time,
    required this.priority,
    required this.isSelected,
    required this.doneButton,
    required this.enterOrEditInfo,
  });

  final int index;
  final String name;
  final String date;
  final String time;
  final bool priority;
  final bool isSelected;
  final VoidCallback doneButton;
  final VoidCallback enterOrEditInfo;

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
        secondChild: ReceptionistsUpcommingExpanededWidget(
          index: index,
          name: name,
          doneButton: doneButton,
          doctor: listOfDoctors[index % listOfDoctors.length],
        ),
        firstChild: ReceptionistsUpcommingCollapsedWidget(
          index: index,
          name: name,
          date: date,
          time: time,
          priority: priority,
          enterOrEditButton: enterOrEditInfo,
        ),
      ),
    );
  }
}
