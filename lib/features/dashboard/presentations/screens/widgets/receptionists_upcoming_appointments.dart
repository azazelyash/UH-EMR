import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../common/constants/dummy_data_upcomming_appointments.dart';
import '../../../../../common/widgets/fade_animation_widget.dart';
import '../../providers/dashboard_provider.dart';
import 'receptionists_upcoming_appointment_tile.dart';

class ReceptionistsUpcomingAppointments extends StatefulWidget {
  const ReceptionistsUpcomingAppointments({super.key});

  @override
  State<ReceptionistsUpcomingAppointments> createState() => _ReceptionistsUpcomingAppointmentsState();
}

class _ReceptionistsUpcomingAppointmentsState extends State<ReceptionistsUpcomingAppointments> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Expanded(flex: 3, child: Text("Name", style: Theme.of(context).textTheme.headlineSmall)),
                SizedBox(width: 6.w),
                Expanded(flex: 3, child: Text("Date/Time", style: Theme.of(context).textTheme.headlineSmall)),
                SizedBox(width: 6.w),
                Expanded(flex: 5, child: Text("Action", style: Theme.of(context).textTheme.headlineSmall)),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(),
        ),
        SliverList.builder(
          itemCount: dummyAppointmentsData.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              index: index,
              widget: ReceptionistsUpcommingAppointmentTile(
                index: index,
                enterOrEditInfo: () {
                  if (context.read<DashboardProvider>().openedUpcomingAppointmentContainer == index) {
                    context.read<DashboardProvider>().openedUpcomingAppointmentContainer = null;
                  } else {
                    context.read<DashboardProvider>().openedUpcomingAppointmentContainer = index;
                  }
                },
                doneButton: () {
                  if (context.read<DashboardProvider>().openedUpcomingAppointmentContainer == index) {
                    context.read<DashboardProvider>().openedUpcomingAppointmentContainer = null;
                  } else {
                    context.read<DashboardProvider>().openedUpcomingAppointmentContainer = index;
                  }
                },
                isSelected: context.watch<DashboardProvider>().openedUpcomingAppointmentContainer == index,
                name: dummyAppointmentsData[index]['name']!,
                date: dummyAppointmentsData[index]['date']!,
                time: dummyAppointmentsData[index]['time']!,
                priority: dummyAppointmentsData[index]['priority']!,
              ),
            );
          },
        ),
      ],
    );
  }
}
