import 'dart:developer';

import 'package:aasa_emr/features/dashboard/presentations/screens/appointment_info_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/colors.dart';
import 'indicator_chip.dart';

class PreviousAppointmentTileClosed extends StatelessWidget {
  const PreviousAppointmentTileClosed({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    appointment.userPatient?.name ?? "-",
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  flex: 4,
                  child: Text(
                    appointment.dateTime != null ? DateFormat.MMMEd().format(appointment.dateTime!) : "-",
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.w),
                Flexible(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IndicatorChip(
                        title: (appointment.status!.appointmentStatus == AppointmentStatusValues.done) ? AppointmentStatusValues.done : AppointmentStatusValues.cancelled,
                        showButton: false,
                        color: (appointment.status!.appointmentStatus == AppointmentStatusValues.done) ? Colors.green : Colors.red,
                        icon: (appointment.status!.appointmentStatus == AppointmentStatusValues.done) ? Icons.check_rounded : Icons.close_rounded,
                        backgroundColor: (appointment.status!.appointmentStatus == AppointmentStatusValues.done) ? Colors.green.shade50 : Colors.red.shade50,
                      ),
                      (appointment.isSold ?? false)
                          ? Padding(
                              padding: EdgeInsets.only(left: 6.sp),
                              child: IndicatorChip(
                                title: appointment.status?.deliveryStatus == null ? "-" : appointment.status!.deliveryStatus!.toUpperCase(),
                                backgroundColor: appointment.status?.deliveryStatus == "intransit" ? Colors.blue.shade50 : Colors.green.shade50,
                                color: appointment.status?.deliveryStatus == "intransit" ? ConstantColors.kPrimaryColor : Colors.green,
                                icon: appointment.status?.deliveryStatus == "intransit" ? Icons.open_in_new : Icons.open_in_new,
                                showButton: true,
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(width: 6.w),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => AppointmentInfoScreen(
                                  appointment: appointment,
                                ),
                              ),
                            );
                          },
                          splashRadius: 20,
                          color: ConstantColors.kHeadlingColor,
                        ),
                      ),
                    ],
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
