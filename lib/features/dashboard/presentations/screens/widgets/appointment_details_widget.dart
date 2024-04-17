import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/models/appointment.dart';
import 'package:intl/intl.dart';

import '../../../../rx_screen/presentation/screens/preview_rx_screen.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppointmentDetailsWidget extends StatefulWidget {
  const AppointmentDetailsWidget({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<AppointmentDetailsWidget> createState() => _AppointmentDetailsWidgetState();
}

class _AppointmentDetailsWidgetState extends State<AppointmentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Details",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                children: [
                  const Text(
                    "Held On",
                    style: TextStyle(
                      color: ConstantColors.kSecondaryColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "${widget.appointment.dateTime == null ? "-" : DateFormat.MMMEd().format(widget.appointment.dateTime!)}, ${widget.appointment.dateTime == null ? "-" : DateFormat.Hm().format(widget.appointment.dateTime!)}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ConstantColors.kSecondaryColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Patient Name",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Contact",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.appointment.userPatient?.name ?? '-',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                widget.appointment.userPatient?.phone?.phoneNumber ?? "-",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Address",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Visit",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  widget.appointment.userPatient?.address ?? "-",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  widget.appointment.visit ?? "-",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ConstantColors.kSecondaryColor,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Expanded(
              //   flex: 6,
              //   child: Row(
              //     children: [
              //       const Text("Rx Status:"),
              //       SizedBox(width: 8.w),
              //       IndicatorChip(
              //         title: (appointment.isSold ?? false) ? "Sold" : "Not Sold",
              //         showButton: false,
              //         color: (appointment.isSold ?? false) ? Colors.green : Colors.red,
              //         icon: (appointment.isSold ?? false) ? Icons.check_rounded : Icons.close_rounded,
              //         backgroundColor: (appointment.isSold ?? false) ? Colors.green.shade50 : Colors.red.shade50,
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 20.w),
              Consumer<AppointmentProvider>(
                builder: (context, appointmentProvider, child) {
                  return Expanded(
                    // flex: 7,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await appointmentProvider.getAppointmentRx(appointmentId: widget.appointment.id);

                          if (appointmentProvider.appointmentRxInfo != null) {
                            if (!mounted) return;
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => PreviewRxScreen(
                                  rxModel: appointmentProvider.appointmentRxInfo!,
                                  appointment: widget.appointment,
                                  isButtonDisabled: true,
                                ),
                              ),
                            );
                          } else {
                            if (!mounted) return;
                            Utils.showSnackBar(context, content: "No Rx found for this appointment");
                          }
                        } catch (e) {
                          Utils.showSnackBar(context, content: e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ConstantColors.kSecondaryColor,
                      ),
                      child: const FittedBox(
                        child: Text("View Rx"),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
