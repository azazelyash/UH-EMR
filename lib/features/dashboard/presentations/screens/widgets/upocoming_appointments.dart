import 'dart:developer';

import 'package:aasa_emr/common/widgets/universal_loading_widget.dart';

import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/dated_appointment_tile.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'upcomming_appointment_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../providers/appointment_provider.dart';
import '../../../../../common/widgets/fade_animation_widget.dart';

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({
    super.key,
  });

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  String? userId;
  List<String>? clinicIds;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    userId = context.read<UserProvider>().user.id;
    final appointmentProvider = context.read<AppointmentProvider>();
    clinicIds = context.read<UserProvider>().selectedClinics.map((e) {
      return e.id!;
    }).toList();
    context.read<AppointmentProvider>().upcomingAppointmentController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, searchController.text, appointmentProvider);
    });

    context.read<AppointmentProvider>().upcomingAppointmentController.refresh();

    super.initState();
  }

  Future<void> _fetchPage(int pageKey, String? searchKey, AppointmentProvider appointmentProvider) async {
    if (!mounted) return;
    // final appointmentProvider = context.read<AppointmentProvider>();
    try {
      GetAppointmentParams getAppointmentParams;
      if (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor) {
        getAppointmentParams = GetAppointmentParams(
          userId: userId!,
          clinicIds: clinicIds!,
          page: pageKey,
          searchKey: searchKey,
        );
      } else {
        getAppointmentParams = GetAppointmentParams(
          userId: context.read<UserProvider>().selectedDoctor!.id!,
          clinicIds: clinicIds!,
          page: pageKey,
          searchKey: searchKey,
        );
      }
      final newItems = await appointmentProvider.getUpcomingAppointments(
        getAppointmentParams,
        informListenersAtStart: false,
      );
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        appointmentProvider.upcomingAppointmentController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        appointmentProvider.upcomingAppointmentController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      appointmentProvider.upcomingAppointmentController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: <Widget>[
            Expanded(flex: 3, child: Text("Name", style: Theme.of(context).textTheme.headlineSmall)),
            SizedBox(width: 4.w),
            Expanded(flex: 3, child: Text("Date/Time", style: Theme.of(context).textTheme.headlineSmall)),
            SizedBox(width: 8.w),
            Expanded(flex: 4, child: Text("Rx Status", style: Theme.of(context).textTheme.headlineSmall)),
            SizedBox(width: 52.w),
          ],
        ),
        const Divider(),
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 44,
                child: TextFormField(
                  controller: searchController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Search Appointments...",
                    suffixIcon: (context.watch<AppointmentProvider>().upcommingSearchKey != null)
                        ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              context.read<AppointmentProvider>().upcommingSearchKey = null;
                              context.read<AppointmentProvider>().upcomingAppointmentController.refresh();
                            },
                            child: const Icon(Icons.close),
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Material(
              color: ConstantColors.kSecondaryColor,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                onTap: () {
                  log("Search");
                  context.read<AppointmentProvider>().upcommingSearchKey = searchController.text;
                  context.read<AppointmentProvider>().upcomingAppointmentController.refresh();
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: ConstantColors.kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Consumer2<AppointmentProvider, DashboardProvider>(
          builder: (context, appointmentProvider, dashboardProvider, child) {
            return Expanded(
              child: SizedBox(
                height: double.infinity,
                child: PagedListView<int, Appointment>(
                  shrinkWrap: true,
                  pagingController: appointmentProvider.upcomingAppointmentController,
                  builderDelegate: PagedChildBuilderDelegate<Appointment>(
                    firstPageProgressIndicatorBuilder: (context) => const UniversalLoadingGif(),
                    // newPageProgressIndicatorBuilder: (context) => const UniversalLoadingWidget(),
                    itemBuilder: (context, item, index) {
                      return FadeAnimation(
                        index: index,
                        widget: GestureDetector(
                          onTap: () {
                            if (dashboardProvider.openedUpcomingAppointmentContainer == index) {
                              dashboardProvider.openedUpcomingAppointmentContainer = null;
                            } else {
                              dashboardProvider.openedUpcomingAppointmentContainer = index;
                            }
                          },
                          child: (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor)
                              ? UpcommingAppointmentTile(
                                  index: index,
                                  appointment: item,
                                  isSelected: dashboardProvider.openedUpcomingAppointmentContainer == index,
                                )
                              : DatedAppointmentTile(
                                  index: index,
                                  appointment: item,
                                  isSelected: dashboardProvider.openedUpcomingAppointmentContainer == index,
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
    );
  }
}
