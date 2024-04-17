import 'package:aasa_emr/common/widgets/cancel_alert_dialog.dart';

import '../../../data/models/appointment.dart';
import '../../../../../common/helper/utils.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/appointment_provider.dart';
import '../../../../../utils/constants/colors.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpcommingTileOpenWidget extends StatefulWidget {
  const UpcommingTileOpenWidget({
    super.key,
    required this.appointment,
  });

  // final String name;
  final Appointment appointment;

  @override
  State<UpcommingTileOpenWidget> createState() => _UpcommingTileOpenWidgetState();
}

class _UpcommingTileOpenWidgetState extends State<UpcommingTileOpenWidget> {
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
          Row(
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
          ),
        ],
      ),
    );
  }
}
