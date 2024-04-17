import 'package:aasa_emr/common/widgets/custom_appbar_with_back_button.dart';
import 'package:aasa_emr/common/widgets/fade_animation_widget.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/dashboard_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/dated_appointment_tile.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShowDateAppointmentScreen extends StatefulWidget {
  const ShowDateAppointmentScreen({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  State<ShowDateAppointmentScreen> createState() => _ShowDateAppointmentScreenState();
}

class _ShowDateAppointmentScreenState extends State<ShowDateAppointmentScreen> {
  String? userId;
  List<String>? clinicIds;
  final PagingController<int, Appointment> datedAppointmentController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    if (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor) {
      userId = context.read<UserProvider>().user.id;
    } else {
      userId = context.read<UserProvider>().selectedDoctor!.id;
    }
    clinicIds = context.read<UserProvider>().selectedClinics.map((e) {
      return e.id!;
    }).toList();
    datedAppointmentController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
      // context.read<AppointmentProvider>().fetchUpcomingAppointmentsWithPagination(pageKey, userId!, clinicIds!);
    });

    datedAppointmentController.refresh();

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (!mounted) return;
    final appointmentProvider = context.read<AppointmentProvider>();
    try {
      final newItems = await appointmentProvider.getDatedAppointments(
        GetAppointmentParams(
          userId: userId!,
          clinicIds: clinicIds!,
          page: pageKey,
          dateTime: widget.selectedDate,
        ),
      );
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        datedAppointmentController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        datedAppointmentController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      datedAppointmentController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomAppBarWithBackButton(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Showing Appointments for:",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat.yMMMd().format(widget.selectedDate),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: ConstantColors.kSecondaryColor,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Name",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Date/Time",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      "Status",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Consumer<DashboardProvider>(
                builder: (context, dashboardProvider, child) {
                  return Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: PagedListView<int, Appointment>(
                        shrinkWrap: true,
                        pagingController: datedAppointmentController,
                        builderDelegate: PagedChildBuilderDelegate<Appointment>(
                          itemBuilder: (context, item, index) {
                            return FadeAnimation(
                              index: index,
                              widget: GestureDetector(
                                onTap: () {
                                  if (dashboardProvider.selectedDatedAppointmentTile == index) {
                                    dashboardProvider.selectedDatedAppointmentTile = null;
                                  } else {
                                    dashboardProvider.selectedDatedAppointmentTile = index;
                                  }
                                },
                                child: DatedAppointmentTile(
                                  index: index,
                                  appointment: item,
                                  isSelected: dashboardProvider.selectedDatedAppointmentTile == index,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
