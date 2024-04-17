import '../../../data/models/appointment.dart';
import '../../providers/dashboard_provider.dart';
import '../../../../../common/helper/utils.dart';
import '../../providers/appointment_provider.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviousAppointmentTileOpened extends StatefulWidget {
  const PreviousAppointmentTileOpened({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  State<PreviousAppointmentTileOpened> createState() => _PreviousAppointmentTileOpenedState();
}

class _PreviousAppointmentTileOpenedState extends State<PreviousAppointmentTileOpened> {
  DateTime? selectedDateTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    initializeValues();
    super.initState();
  }

  initializeValues() {
    if (widget.appointment.dateTime != null) {
      selectedDateTime = widget.appointment.dateTime!;
    }
    dateController = TextEditingController(
        text: widget.appointment.dateTime != null ? DateFormat.yMMMd().format(widget.appointment.dateTime!) : null);
    timeController = TextEditingController(
        text: widget.appointment.dateTime != null ? DateFormat.jmz().format(widget.appointment.dateTime!) : null);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      widget.appointment.userPatient?.name ?? "-",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Contact",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      widget.appointment.userPatient?.phone?.phoneNumber ?? "-",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Text("Edit Date: "),
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          showCursor: false,
                          onTap: widget.appointment.status!.appointmentStatus != AppointmentStatusValues.cancelled
                              ? null
                              : () async {
                                  selectedDateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now().add(const Duration(days: 700)),
                                    firstDate: DateTime.now(),
                                  );
                                  timeController.text = DateFormat.jmz().format(selectedDateTime!);
                                  if (selectedDateTime != null) {
                                    dateController.text = DateFormat.yMMMd().format(selectedDateTime!);
                                  }
                                },
                          controller: dateController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Text("Edit Time: "),
                    Expanded(
                      child: SizedBox(
                        height: 32,
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.none,
                          showCursor: false,
                          onTap: widget.appointment.status!.appointmentStatus != AppointmentStatusValues.cancelled
                              ? null
                              : () async {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedDateTime != null) {
                                    selectedDateTime = DateTime(
                                      selectedDateTime!.year,
                                      selectedDateTime!.month,
                                      selectedDateTime!.day,
                                      selectedTime!.hour,
                                      selectedTime.minute,
                                    );
                                    timeController.text = DateFormat.jmz().format(selectedDateTime!);
                                  }
                                },
                          controller: timeController,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (widget.appointment.status!.appointmentStatus == AppointmentStatusValues.cancelled)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (selectedDateTime != null) {
                          if (selectedDateTime!.isBefore(DateTime.now())) {
                            Utils.showSnackBar(context, content: "Please Select a Valid Schedule");
                            return;
                          }
                          final appointmentProvider = context.read<AppointmentProvider>();
                          Appointment newAppointment = widget.appointment.copyWith(
                            dateTime: selectedDateTime,
                            status: Status(
                              appointmentStatus: AppointmentStatusValues.pending,
                            ),
                          );

                          await appointmentProvider.updateAppointment(newAppointment);
                          appointmentProvider.previousAppointmentController.refresh();
                          appointmentProvider.upcomingAppointmentController.refresh();
                          if (!mounted) return;
                          context.read<DashboardProvider>().openedPreviousAppointmentContainer = null;
                          Utils.showSnackBar(context, content: "Appointment Rescheduled");
                        }
                      } catch (e) {
                        rethrow;
                      }
                    },
                    child: const Text("Reschedule"),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
