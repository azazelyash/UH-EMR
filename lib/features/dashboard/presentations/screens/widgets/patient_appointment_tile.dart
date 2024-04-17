import 'package:aasa_emr/common/helper/date_time_parser.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../appointment_info_screen.dart';

class PatientAppointmentTile extends StatelessWidget {
  const PatientAppointmentTile({
    super.key,
    required this.index,
    required this.appointment,
  });

  final int index;
  final Appointment? appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              appointment?.userDoctor?.doctorProfile?.name ?? "-",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: Text(
              (appointment?.dateTime != null)
                  ? DateTimeParser.parseDate(
                      appointment!.dateTime!.toLocal().toString().split(" ").first,
                    )
                  : "-",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    appointment?.visit ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: () {
                      if (appointment != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AppointmentInfoScreen(
                              appointment: appointment!,
                            ),
                          ),
                        );
                      } else {
                        Utils.showSnackBar(context, content: "An error occured");
                      }
                    },
                    child: const Text("View Info"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
