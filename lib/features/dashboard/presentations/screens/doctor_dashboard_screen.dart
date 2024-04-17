import 'package:aasa_emr/features/dashboard/presentations/screens/show_date_appointment_screen.dart';
import 'package:aasa_emr/service/analytics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/previous_appointments.dart';
import 'widgets/start_rx_bottom_sheet.dart';
import 'widgets/upocoming_appointments.dart';
import '../../../../common/helper/utils.dart';
import '../providers/dashboard_provider.dart';
import '../providers/appointment_provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../common/widgets/custom_appbar.dart';
import '../../domain/usecases/get_appointments_usecase.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  GetAppointmentParams? getAppointmentParams;
  final ScrollController scrollController = ScrollController();
  bool showSearchField = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // final userId = context.read<UserProvider>().user.id;
    // final clinicIds = context.read<UserProvider>().selectedClinic.map((e) {
    //   return e.id!;
    // }).toList();
    // final appointmentProvider = context.read<AppointmentProvider>();
    // appointmentProvider.previousAppointmentController.addPageRequestListener((pageKey) {
    //   appointmentProvider.fetchPreviousAppointmentsWithPagination(pageKey, userId!, clinicIds);
    // });
    // appointmentProvider.upcomingAppointmentController.addPageRequestListener((pageKey) {
    //   // _fetchPage(pageKey);
    //   appointmentProvider.fetchUpcomingAppointmentsWithPagination(pageKey, userId!, clinicIds);
    // });
    // appointmentProvider.upcomingAppointmentController.refresh();
    // appointmentProvider.previousAppointmentController.refresh();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // @override
  // void deactivate() {
  //   context.read<AppointmentProvider>().previousAppointmentController.removePageRequestListener((pageKey) {});
  //   context.read<AppointmentProvider>().upcomingAppointmentController.removePageRequestListener((pageKey) {});
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    getAppointmentParams = GetAppointmentParams(
      userId: context.read<UserProvider>().user.id!,
      clinicIds: context.read<UserProvider>().selectedClinics.map((e) => e.id!).toList(),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomAppBar(),
              SizedBox(height: 16.h),
              ExpandedElevatedButton(
                title: "Start New Rx",
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.kSecondaryColor,
                ),
                icon: const Icon(Icons.add_chart),
                onTap: () async {
                  try {
                    Analytics.logStartNewRx();
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
                          child: const StartRxBottomSheet(),
                        );
                        // return const StartRxBottomSheet();
                      },
                    );

                    if (!mounted) return;
                    context.read<AppointmentProvider>().upcomingAppointmentController.refresh();
                  } catch (e) {
                    if (context.mounted) {
                      Utils.showSnackBar(
                        context,
                        content: e.toString(),
                      );
                    }
                  }

                  if (context.mounted) {
                    context.read<DashboardProvider>().creatRxState = false;
                    context.read<DashboardProvider>().createNewPatient = false;
                    context.read<DashboardProvider>().fillDetailsState = false;
                    context.read<DashboardProvider>().startConsulationNow = false;
                  }
                },
              ),
              SizedBox(height: 16.h),
              Material(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Strings.appointments,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(width: 4.w),
                    Consumer2<AppointmentProvider, UserProvider>(
                      builder: (context, appointmentProvider, userProvider, _) {
                        // final userId = userProvider.user.id!;
                        // final clinicIds = userProvider.selectedClinic.map((e) => e.id!).toList();
                        return Row(
                          children: [
                            // IconButton(
                            //   iconSize: 20,
                            //   splashRadius: 20,
                            //   padding: EdgeInsets.zero,
                            //   visualDensity: VisualDensity.compact,
                            //   onPressed: () async {
                            //     showSearchField = true;
                            //     setState(() {});
                            //   },
                            //   icon: const Icon(Icons.search, color: ConstantColors.kHeadlingColor),
                            // ),
                            IconButton(
                              iconSize: 20,
                              splashRadius: 20,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(Icons.calendar_month_outlined, color: ConstantColors.kHeadlingColor),
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now().subtract(const Duration(days: 700)),
                                  lastDate: DateTime.now().add(const Duration(days: 700)),
                                );

                                if (selectedDate != null) {
                                  if (!mounted) return;
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => ShowDateAppointmentScreen(selectedDate: selectedDate),
                                    ),
                                  );
                                }

                                // final userId = context.read<UserProvider>().user.id!;
                                // final clinicIds = context.read<UserProvider>().selectedClinic.map((e) => e.id!).toList();
                                // final selectedDate = await showDatePicker(
                                //   context: context,
                                //   initialDate: DateTime.now(),
                                //   firstDate: DateTime.now().subtract(const Duration(days: 700)),
                                //   lastDate: DateTime.now().add(const Duration(days: 700)),
                                // );
                                // appointmentProvider.selectedDate = selectedDate;
                                // appointmentProvider.upcomingAppointmentController.refresh();
                                // appointmentProvider.previousAppointmentController.refresh();
                                // if (selectedDate != null) {
                                //   appointmentProvider.updateUsingDateStatus(true);
                                // }
                                // if (selectedDate != null) {
                                //
                                //   final GetAppointmentParams getAppointmentParams = GetAppointmentParams(
                                //     userId: userId,
                                //     clinicIds: clinicIds,
                                //     dateTime: selectedDate,
                                //   );
                                //   try {
                                //     context
                                //         .read<AppointmentProvider>()
                                //         .upcomingAppointmentController
                                //         .addPageRequestListener((pageKey) async {
                                //       await appointmentProvider.fetchUpcomingAppointmentsWithPagination(
                                //         pageKey,
                                //         userId,
                                //         clinicIds,
                                //         dateTime: selectedDate,
                                //       );
                                //     });
                                //   } catch (e) {
                                //     if (context.mounted) {
                                //       Utils.showSnackBar(
                                //         context,
                                //         content: e.toString(),
                                //       );
                                //     }
                                //   }
                                // }
                              },
                            ),
                            // if (appointmentProvider.usingDate)
                            //   GestureDetector(
                            //     onTap: () async {
                            //       appointmentProvider.updateUsingDateStatus(false);
                            //       appointmentProvider.upcomingAppointmentController.refresh();
                            //       appointmentProvider.previousAppointmentController.refresh();
                            //       final userId = context.read<UserProvider>().user.id!;
                            //       final clinicIds =
                            //           context.read<UserProvider>().selectedClinic.map((e) => e.id!).toList();

                            //       appointmentProvider.updateUsingDateStatus(false);
                            //       final GetAppointmentParams getAppointmentParams = GetAppointmentParams(
                            //         userId: userId,
                            //         clinicIds: clinicIds,
                            //       );
                            //       try {
                            //         context
                            //             .read<AppointmentProvider>()
                            //             .upcomingAppointmentController
                            //             .addPageRequestListener((pageKey) async {
                            //           await appointmentProvider.fetchUpcomingAppointmentsWithPagination(
                            //               pageKey, userId, clinicIds);
                            //         });
                            //       } catch (e) {
                            //         if (context.mounted) {
                            //           Utils.showSnackBar(
                            //             context,
                            //             content: e.toString(),
                            //           );
                            //         }
                            //       }
                            //     },
                            //     child: Container(
                            //       height: 18,
                            //       width: 18,
                            //       decoration: const BoxDecoration(
                            //         color: Colors.red,
                            //         shape: BoxShape.circle,
                            //       ),
                            //       child: const Center(
                            //         child: Icon(
                            //           Icons.close,
                            //           color: Colors.white,
                            //           size: 10,
                            //         ),
                            //       ),
                            //     ),
                            //   )
                          ],
                        );
                      },
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: ConstantColors.kWhiteColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xffB9E3DA),
                            width: 1,
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          onTap: (value) {
                            context.read<AppointmentProvider>().previousSearchKey = null;
                            context.read<AppointmentProvider>().upcommingSearchKey = null;
                          },
                          indicator: BoxDecoration(
                            color: const Color(0xffE9FDF3),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: ConstantColors.kSecondaryColor,
                              width: 0.6,
                            ),
                          ),
                          labelColor: ConstantColors.kSecondaryColor,
                          unselectedLabelColor: ConstantColors.kHeadlingColor,
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.tab,
                          physics: const NeverScrollableScrollPhysics(),
                          labelStyle: Theme.of(context).textTheme.titleSmall,
                          tabs: const <Widget>[
                            FittedBox(child: Tab(text: "Upcoming")),
                            FittedBox(child: Tab(text: "Previous")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              // if (showSearchField) ...[
              //   AnimatedCrossFade(
              //     crossFadeState: showSearchField ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              //     duration: const Duration(seconds: 1),
              //     firstChild: const SizedBox.shrink(),
              //     secondChild: TextField(
              //       decoration: InputDecoration(
              //         suffixIcon: Material(
              //           color: Colors.transparent,
              //           child: IconButton(
              //             onPressed: () {
              //               showSearchField = false;
              //               setState(() {});
              //             },
              //             splashRadius: 20,
              //             padding: EdgeInsets.zero,
              //             visualDensity: VisualDensity.compact,
              //             icon: const Icon(Icons.close),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //   SizedBox(height: 10.h),
              // ],
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const <Widget>[
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Row(
                    //       children: <Widget>[
                    //         Expanded(flex: 3, child: Text("Name", style: Theme.of(context).textTheme.headlineSmall)),
                    //         SizedBox(width: 4.w),
                    //         Expanded(flex: 3, child: Text("Date/Time", style: Theme.of(context).textTheme.headlineSmall)),
                    //         SizedBox(width: 8.w),
                    //         Expanded(flex: 4, child: Text("Rx Status", style: Theme.of(context).textTheme.headlineSmall)),
                    //         SizedBox(width: 52.w),
                    //       ],
                    //     ),
                    //     const Divider(),
                    //     Consumer2<AppointmentProvider, DashboardProvider>(
                    //       builder: (context, appointmentProvider, dashboardProvider, child) {
                    //         return Expanded(
                    //           child: SizedBox(
                    //             height: double.infinity,
                    //             child: PagedListView<int, Appointment>(
                    //               shrinkWrap: true,
                    //               pagingController: appointmentProvider.upcomingAppointmentController,
                    //               builderDelegate: PagedChildBuilderDelegate<Appointment>(
                    //                 itemBuilder: (context, item, index) {
                    //                   return FadeAnimation(
                    //                     index: index,
                    //                     widget: GestureDetector(
                    //                       onTap: () {
                    //                         if (dashboardProvider.openedUpcomingAppointmentContainer == index) {
                    //                           dashboardProvider.openedUpcomingAppointmentContainer = null;
                    //                         } else {
                    //                           dashboardProvider.openedUpcomingAppointmentContainer = index;
                    //                         }
                    //                       },
                    //                       child: UpcommingAppointmentTile(
                    //                         index: index,
                    //                         appointment: item,
                    //                         isSelected: dashboardProvider.openedUpcomingAppointmentContainer == index,
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // ),
                    UpcomingAppointments(),
                    PreviousAppointments(),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Row(
                    //       children: <Widget>[
                    //         Expanded(flex: 3, child: Text("Name", style: Theme.of(context).textTheme.headlineSmall)),
                    //         SizedBox(width: 6.w),
                    //         Expanded(flex: 4, child: Text("Date", style: Theme.of(context).textTheme.headlineSmall)),
                    //         SizedBox(width: 6.w),
                    //         Expanded(flex: 5, child: Text("Rx Status", style: Theme.of(context).textTheme.headlineSmall)),
                    //       ],
                    //     ),
                    //     const Divider(),
                    //     Consumer2<AppointmentProvider, DashboardProvider>(
                    //       builder: (context, appointmentProvider, dashboardProvider, child) {
                    //         return Expanded(
                    //           child: SizedBox(
                    //             height: double.infinity,
                    //             child: PagedListView<int, Appointment>(
                    //               shrinkWrap: true,
                    //               pagingController: appointmentProvider.previousAppointmentController,
                    //               builderDelegate: PagedChildBuilderDelegate<Appointment>(
                    //                 itemBuilder: (context, item, index) {
                    //                   return FadeAnimation(
                    //                     index: index,
                    //                     widget: GestureDetector(
                    //                       onTap: () {
                    //                         if (dashboardProvider.openedPreviousAppointmentContainer == index) {
                    //                           dashboardProvider.openedPreviousAppointmentContainer = null;
                    //                         } else {
                    //                           dashboardProvider.openedPreviousAppointmentContainer = index;
                    //                         }
                    //                       },
                    //                       child: PreviousAppointmentTile(
                    //                         index: index,
                    //                         appointment: item,
                    //                         isSelected: dashboardProvider.openedPreviousAppointmentContainer == index,
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
