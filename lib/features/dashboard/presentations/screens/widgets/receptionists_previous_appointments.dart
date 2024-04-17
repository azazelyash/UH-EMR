import 'receptionists_previous_appointment_tile.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/fade_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/constants/dummy_data_upcomming_appointments.dart';

class ReceptionistsPreviousAppointments extends StatefulWidget {
  const ReceptionistsPreviousAppointments({super.key});

  @override
  State<ReceptionistsPreviousAppointments> createState() => _ReceptionistsPreviousAppointmentsState();
}

class _ReceptionistsPreviousAppointmentsState extends State<ReceptionistsPreviousAppointments> {
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
                Expanded(
                  flex: 2,
                  child: Text(
                    "Name",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Date",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Rx Status",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
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
              widget: ReceptionistsPreviousAppointmentTile(
                onTap: () {
                  // Navigator.of(context).push(
                  //   CupertinoPageRoute(
                  //     builder: (context) => AppointmentInfoScreen(
                  //       index: index,
                  //       name: dummyAppointmentsData[index]['name']!,
                  //       date: dummyAppointmentsData[index]['date']!,
                  //       time: dummyAppointmentsData[index]['time']!,
                  //       rxStatus: dummyAppointmentsData[index]['rx_status']!,
                  //       rxSoldStatus: (dummyAppointmentsData[index]['rx_status'] == 'sold')
                  //           ? dummyAppointmentsData[index]['sold_status']
                  //           : "",
                  //     ),
                  //   ),
                  // );
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
