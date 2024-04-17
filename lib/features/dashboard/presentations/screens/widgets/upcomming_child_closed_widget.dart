import 'package:aasa_emr/service/analytics.dart';

import '../../../../../common/helper/utils.dart';
import '../../providers/appointment_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/appointment.dart';
import '../patient_info_screen.dart';
import 'start_instant_rx_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcommingChildClosedWidget extends StatefulWidget {
  const UpcommingChildClosedWidget({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<UpcommingChildClosedWidget> createState() => _UpcommingChildClosedWidgetState();
}

class _UpcommingChildClosedWidgetState extends State<UpcommingChildClosedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              widget.appointment.userPatient?.name ?? "-",
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.appointment.dateTime != null ? DateFormat.yMd().format(widget.appointment.dateTime!) : "-",
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  widget.appointment.dateTime != null ? DateFormat.jmz().format(widget.appointment.dateTime!) : "-",
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () async {
                Analytics.logStartRxNow();
                await showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: StartInstantRxBottomSheet(
                        appointment: widget.appointment,
                      ),
                    );
                  },
                );

                if (!mounted) return;

                context.read<AppointmentProvider>().upcomingAppointmentController.refresh();

                if (!mounted) return;

                try {
                  context.read<AppointmentProvider>().upcomingAppointmentController.refresh();
                } catch (e) {
                  if (context.mounted) {
                    Utils.showSnackBar(
                      context,
                      content: e.toString(),
                    );
                  }
                }
              },
              child: const Text("Start Rx Now"),
            ),
          ),
          SizedBox(width: 4.w),
          Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () async {
                await context.read<AppointmentProvider>().getPatientAppointments(
                      patientId: widget.appointment.userPatient!.id!,
                    );

                if (!mounted) return;
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => PatientInfoScreen(
                      patient: widget.appointment.userPatient!,
                    ),
                  ),
                );
              },
              splashRadius: 20,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.info_outline),
              visualDensity: VisualDensity.compact,
              color: ConstantColors.kHeadlingColor,
            ),
          ),
        ],
      ),
    );
  }
}
