import 'package:aasa_emr/common/widgets/universal_loading_widget.dart';

import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/dashboard_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/dated_appointment_tile.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/previous_appointment_tile.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/utils/constants/colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/fade_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PreviousAppointments extends StatefulWidget {
  const PreviousAppointments({super.key});

  @override
  State<PreviousAppointments> createState() => _PreviousAppointmentsState();
}

class _PreviousAppointmentsState extends State<PreviousAppointments> {
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
    context.read<AppointmentProvider>().previousAppointmentController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, searchController.text, appointmentProvider);
    });

    context.read<AppointmentProvider>().previousAppointmentController.refresh();

    super.initState();
  }

  Future<void> _fetchPage(int pageKey, String? searchKey, AppointmentProvider appointmentProvider) async {
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
      final newItems = await appointmentProvider.getPreviousAppointments(
        getAppointmentParams,
        informListenersAtStart: false,
      );
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        appointmentProvider.previousAppointmentController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        appointmentProvider.previousAppointmentController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      appointmentProvider.previousAppointmentController.error = error;
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
            SizedBox(width: 6.w),
            Expanded(flex: 4, child: Text("Date", style: Theme.of(context).textTheme.headlineSmall)),
            SizedBox(width: 6.w),
            Expanded(flex: 5, child: Text("Rx Status", style: Theme.of(context).textTheme.headlineSmall)),
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
                    suffixIcon: (context.watch<AppointmentProvider>().previousSearchKey != null)
                        ? GestureDetector(
                            onTap: () {
                              searchController.clear();
                              context.read<AppointmentProvider>().previousSearchKey = null;
                              context.read<AppointmentProvider>().previousAppointmentController.refresh();
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
                  context.read<AppointmentProvider>().previousSearchKey = searchController.text;
                  context.read<AppointmentProvider>().previousAppointmentController.refresh();
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
                  pagingController: appointmentProvider.previousAppointmentController,
                  builderDelegate: PagedChildBuilderDelegate<Appointment>(
                    firstPageProgressIndicatorBuilder: (context) => const UniversalLoadingGif(),
                    itemBuilder: (context, item, index) {
                      return FadeAnimation(
                        index: index,
                        widget: GestureDetector(
                          onTap: () {
                            if (dashboardProvider.openedPreviousAppointmentContainer == index) {
                              dashboardProvider.openedPreviousAppointmentContainer = null;
                            } else {
                              dashboardProvider.openedPreviousAppointmentContainer = index;
                            }
                          },
                          child: (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor)
                              ? PreviousAppointmentTile(
                                  index: index,
                                  appointment: item,
                                  isSelected: dashboardProvider.openedPreviousAppointmentContainer == index,
                                )
                              : DatedAppointmentTile(
                                  index: index,
                                  appointment: item,
                                  isSelected: dashboardProvider.openedPreviousAppointmentContainer == index,
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
