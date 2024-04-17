import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../providers/dashboard_provider.dart';
import 'receptionists_pending_tile_collapsed.dart';
import 'receptionists_pending_tile_expanded.dart';

class PendingAppointmentTile extends StatelessWidget {
  const PendingAppointmentTile({
    super.key,
    this.rxSoldStatus,
    required this.index,
    required this.name,
    required this.date,
    required this.time,
    required this.rxStatus,
    required this.completeFormalities,
  });

  final int index;
  final String name;
  final String date;
  final String time;
  final String rxStatus;
  final String? rxSoldStatus;
  final VoidCallback completeFormalities;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ConstantColors.kTileBackgroundColor,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 250),
        firstCurve: Curves.easeOut,
        secondCurve: Curves.easeIn,
        sizeCurve: Curves.easeInOut,
        crossFadeState: (context.watch<DashboardProvider>().selectedPendingTile == index)
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        secondChild: ReceptionistsPendingTileExpanded(
          name: name,
          date: date,
          time: time,
          index: index,
          completeFormalities: completeFormalities,
        ),
        firstChild: ReceptionistsPendingTileCollapsed(
          name: name,
          date: date,
          time: time,
          completeFormalities: completeFormalities,
        ),
      ),
    );
  }
}
