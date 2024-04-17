import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/dummy_data_upcomming_appointments.dart';
import '../../../../../common/widgets/fade_animation_widget.dart';
import '../../../../rx_screen/presentation/screens/complete_formalities_screen.dart';
import 'receptionists_pending_tile.dart';

class ReceptionistsPendingAppointments extends StatefulWidget {
  const ReceptionistsPendingAppointments({super.key});

  @override
  State<ReceptionistsPendingAppointments> createState() => _ReceptionistsPendingAppointmentsState();
}

class _ReceptionistsPendingAppointmentsState extends State<ReceptionistsPendingAppointments> {
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
                SizedBox(width: 8.w),
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
              widget: PendingAppointmentTile(
                completeFormalities: () {
                  // if (context.read<DashboardProvider>().selectedPendingTile == index) {
                  //   context.read<DashboardProvider>().selectedPendingTile = null;
                  // } else {
                  //   context.read<DashboardProvider>().selectedPendingTile = index;
                  // }
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => CompleteFormalities(
                        name: dummyAppointmentsData[index]['name']!,
                        date: dummyAppointmentsData[index]['date']!,
                        time: dummyAppointmentsData[index]['time']!,
                      ),
                    ),
                  );
                },
                index: index,
                name: dummyAppointmentsData[index]['name']!,
                date: dummyAppointmentsData[index]['date']!,
                time: dummyAppointmentsData[index]['time']!,
                rxStatus: dummyAppointmentsData[index]['rx_status']!,
                rxSoldStatus: (dummyAppointmentsData[index]['rx_status'] == 'sold')
                    ? dummyAppointmentsData[index]['sold_status']
                    : "",
              ),
            );
          },
        ),
      ],
    );
  }
}
