import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/dated_appointment_tile_collapsed.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/dated_appointment_tile_expanded.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatedAppointmentTile extends StatelessWidget {
  const DatedAppointmentTile({
    super.key,
    required this.index,
    required this.isSelected,
    required this.appointment,
  });

  final int index;
  final bool isSelected;
  final Appointment appointment;

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
        firstChild: DatedAppointmentTileCollapsed(
          appointment: appointment,
        ),
        secondChild: DatedAppointmentTileExpanded(
          appointment: appointment,
        ),
      ),
    );
  }
}
