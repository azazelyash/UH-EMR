import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/common/widgets/cancel_alert_dialog.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/dashboard_provider.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatedAppointmentTileExpanded extends StatefulWidget {
  const DatedAppointmentTileExpanded({super.key, required this.appointment});

  final Appointment appointment;

  @override
  State<DatedAppointmentTileExpanded> createState() => _DatedAppointmentTileExpandedState();
}

class _DatedAppointmentTileExpandedState extends State<DatedAppointmentTileExpanded> {
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
    dateController = TextEditingController(text: widget.appointment.dateTime != null ? DateFormat.yMMMd().format(widget.appointment.dateTime!) : null);
    timeController = TextEditingController(text: widget.appointment.dateTime != null ? DateFormat.jmz().format(widget.appointment.dateTime!) : null);
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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
              )
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.appointment.userPatient?.name ?? "-",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Expanded(
                child: Text(
                  "${widget.appointment.userPatient?.phone?.countryCode ?? "-"} ${widget.appointment.userPatient?.phone?.phoneNumber ?? "-"}",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
            ],
          ),
          SizedBox(height: 8.h),
          (widget.appointment.status!.appointmentStatus != AppointmentStatusValues.done)
              ? Column(
                  children: [
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
                                    onTap: () async {
                                      selectedDateTime = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now().add(const Duration(days: 700)),
                                        firstDate: DateTime.now(),
                                      );
                                      if (selectedDateTime != null) {
                                        dateController.text = DateFormat.yMMMd().format(selectedDateTime!);
                                      }
                                    },
                                    controller: dateController,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      // hintText: widget.appointment.schedule?.dateTime != null
                                      //     ? DateFormat.yMMMd().format(widget.appointment.schedule!.dateTime!)
                                      //     : "-",
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
                                    onTap: () async {
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
                                      // hintText: widget.appointment.schedule?.dateTime != null
                                      //     ? DateFormat.jmz().format(widget.appointment.schedule!.dateTime!)
                                      //     : "-",
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
                    (widget.appointment.status!.appointmentStatus == AppointmentStatusValues.pending)
                        ? Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CancelPopupWidget(
                                          content: "Are you sure you want to cancel this Appointment?",
                                          confirmButtonFunction: () async {
                                            try {
                                              final appointmentProvider = context.read<AppointmentProvider>();

                                              Appointment newAppointment = widget.appointment.copyWith(
                                                status: widget.appointment.status?.copyWith(
                                                  appointmentStatus: AppointmentStatusValues.cancelled,
                                                ),
                                              );
                                              await appointmentProvider.updateAppointment(newAppointment);
                                              appointmentProvider.upcomingAppointmentController.refresh();
                                              appointmentProvider.previousAppointmentController.refresh();

                                              if (!mounted) return;
                                              Utils.showSnackBar(
                                                context,
                                                content: "Appointment Updated Successfully",
                                              );
                                              initializeValues();
                                              context.read<DashboardProvider>().openedUpcomingAppointmentContainer = null;
                                            } catch (e) {
                                              if (context.mounted) {
                                                Utils.showSnackBar(
                                                  context,
                                                  content: e.toString(),
                                                );
                                              }
                                            }
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: ConstantColors.kErrorColor),
                                    foregroundColor: ConstantColors.kErrorColor,
                                    surfaceTintColor: ConstantColors.kErrorColor,
                                  ),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (selectedDateTime != null) {
                                      try {
                                        final appointmentProvider = context.read<AppointmentProvider>();
                                        Appointment newAppointment = widget.appointment.copyWith(dateTime: selectedDateTime);

                                        try {
                                          await appointmentProvider.updateAppointment(newAppointment);
                                          appointmentProvider.upcomingAppointmentController.refresh();
                                        } catch (e) {
                                          if (context.mounted) {
                                            Utils.showSnackBar(
                                              context,
                                              content: e.toString(),
                                            );
                                          }
                                        }
                                      } catch (e) {
                                        rethrow;
                                      }
                                    }
                                  },
                                  child: const Text("Done"),
                                ),
                              ),
                            ],
                          )
                        : Row(
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
                )
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Date:",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            DateFormat.yMMMd().format(widget.appointment.dateTime!),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Time:",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            DateFormat.jmz().format(widget.appointment.dateTime!),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
