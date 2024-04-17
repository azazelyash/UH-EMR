import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/features/dashboard/domain/usecases/get_appointments_usecase.dart';
import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/show_date_appointment_screen.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/previous_appointments.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/widgets/upocoming_appointments.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/receptionists_app_bar.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';
import '../providers/dashboard_provider.dart';
import 'widgets/start_rx_bottom_sheet.dart';

class ReceptionistsDashboardScreen extends StatefulWidget {
  const ReceptionistsDashboardScreen({super.key});

  @override
  State<ReceptionistsDashboardScreen> createState() => _ReceptionistsDashboardScreenState();
}

class _ReceptionistsDashboardScreenState extends State<ReceptionistsDashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  GetAppointmentParams? getAppointmentParams;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getAppointmentParams = GetAppointmentParams(
      userId: context.read<UserProvider>().user.id!,
      clinicIds: context.read<UserProvider>().selectedClinics.map((e) => e.id!).toList(),
    );
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.sp),
        child: ExpandedElevatedButton(
          title: "Create Appointment",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: ConstantColors.kSecondaryColor,
          ),
          icon: const Icon(Icons.add_chart),
          onTap: () async {
            try {
              context.read<DashboardProvider>().creatRxState = true;
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReceptionistsAppBar(
                onTap: () {
                  Navigator.of(context).pop();
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
                        return Row(
                          children: [
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
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Container(
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
              SizedBox(height: 12.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const <Widget>[
                    UpcomingAppointments(),
                    PreviousAppointments(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: true,
  //     bottomNavigationBar: Container(
  //       color: Colors.white,
  //       padding: EdgeInsets.all(10.sp),
  //       child: ExpandedElevatedButton(
  //         title: "Start New Rx",
  //         buttonStyle: ElevatedButton.styleFrom(
  //           backgroundColor: ConstantColors.kSecondaryColor,
  //         ),
  //         icon: const Icon(Icons.add_chart),
  //         onTap: () async {
  //           await showModalBottomSheet(
  //             context: context,
  //             useSafeArea: true,
  //             isScrollControlled: true,
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(12),
  //                 topRight: Radius.circular(12),
  //               ),
  //             ),
  //             builder: (context) {
  //               return Padding(
  //                 padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //                 child: const StartRxBottomSheet(),
  //               );
  //             },
  //           );

  //           if (!mounted) return;
  //           context.read<DashboardProvider>().creatRxState = false;
  //           context.read<DashboardProvider>().createNewPatient = false;
  //           context.read<DashboardProvider>().fillDetailsState = false;
  //           context.read<DashboardProvider>().startConsulationNow = false;
  //         },
  //       ),
  //     ),
  //     body: SafeArea(
  //       child: Stack(
  //         children: [
  //           NestedScrollView(
  //             headerSliverBuilder: (context, innerBoxIsScrolled) {
  //               return [
  //                 SliverAppBar(
  //                   pinned: true,
  //                   floating: true,
  //                   expandedHeight: 184.sp,
  //                   backgroundColor: Colors.white,
  //                   automaticallyImplyLeading: false,
  //                   flexibleSpace: FlexibleSpaceBar(
  //                     collapseMode: CollapseMode.parallax,
  //                     background: Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
  //                       child: Column(
  //                         children: [
  //                           ReceptionistsAppBar(
  //                             showBackButton: true,
  //                             onTap: () {
  //                               Navigator.of(context).pop();
  //                             },
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   bottom: PreferredSize(
  //                     preferredSize: Size.fromHeight(100.h),
  //                     child: Material(
  //                       color: Colors.white,
  //                       child: Padding(
  //                         padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h, top: 8.h),
  //                         child: Column(
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: <Widget>[
  //                                 Text(
  //                                   Strings.appointments,
  //                                   style: Theme.of(context).textTheme.headlineLarge,
  //                                 ),
  //                                 SizedBox(width: 4.w),
  //                                 Row(
  //                                   children: [
  //                                     // IconButton(
  //                                     //   iconSize: 20,
  //                                     //   splashRadius: 20,
  //                                     //   padding: EdgeInsets.zero,
  //                                     //   visualDensity: VisualDensity.compact,
  //                                     //   onPressed: () {
  //                                     //     log("Search");
  //                                     //   },
  //                                     //   icon: const Icon(Icons.search, color: ConstantColors.kHeadlingColor),
  //                                     // ),
  //                                     IconButton(
  //                                       iconSize: 20,
  //                                       splashRadius: 20,
  //                                       padding: EdgeInsets.zero,
  //                                       visualDensity: VisualDensity.compact,
  //                                       onPressed: () async {
  //                                         final selectedDate = await showDatePicker(
  //                                           context: context,
  //                                           initialDate: DateTime.now(),
  //                                           firstDate: DateTime.now().subtract(const Duration(days: 700)),
  //                                           lastDate: DateTime.now().add(const Duration(days: 700)),
  //                                         );

  //                                         if (selectedDate != null) {
  //                                           if (!mounted) return;
  //                                           Navigator.of(context).push(
  //                                             CupertinoPageRoute(
  //                                               builder: (context) => ShowDateAppointmentScreen(selectedDate: selectedDate),
  //                                             ),
  //                                           );
  //                                         }
  //                                       },
  //                                       icon: const Icon(Icons.calendar_month_outlined, color: ConstantColors.kHeadlingColor),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(height: 8.h),
  //                             Container(
  //                               height: 40,
  //                               decoration: BoxDecoration(
  //                                 color: ConstantColors.kWhiteColor,
  //                                 borderRadius: BorderRadius.circular(6),
  //                                 border: Border.all(
  //                                   color: const Color(0xffB9E3DA),
  //                                   width: 1,
  //                                 ),
  //                               ),
  //                               child: TabBar(
  //                                 controller: _tabController,
  //                                 padding: EdgeInsets.zero,
  //                                 labelPadding: EdgeInsets.zero,
  //                                 indicatorPadding: EdgeInsets.zero,
  //                                 indicatorSize: TabBarIndicatorSize.tab,
  //                                 labelColor: ConstantColors.kSecondaryColor,
  //                                 physics: const NeverScrollableScrollPhysics(),
  //                                 labelStyle: Theme.of(context).textTheme.titleSmall,
  //                                 unselectedLabelColor: ConstantColors.kHeadlingColor,
  //                                 indicator: BoxDecoration(
  //                                   color: const Color(0xffE9FDF3),
  //                                   borderRadius: BorderRadius.circular(6),
  //                                   border: Border.all(
  //                                     color: ConstantColors.kSecondaryColor,
  //                                     width: 0.6,
  //                                   ),
  //                                 ),
  //                                 tabs: const <Widget>[
  //                                   FittedBox(child: Tab(text: "Upcoming")),
  //                                   // FittedBox(child: Tab(text: "Pending")),
  //                                   FittedBox(child: Tab(text: "Previous")),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ];
  //             },
  //             body: Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //               child: TabBarView(
  //                 controller: _tabController,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 children: const <Widget>[
  //                   UpcomingAppointments(),
  //                   PreviousAppointments(),
  //                   // ReceptionistsUpcomingAppointments(),
  //                   // ReceptionistsPendingAppointments(),
  //                   // ReceptionistsPreviousAppointments(),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           (context.watch<AuthProvider>().isLoading) ? const UniversalLoadingWidget() : const SizedBox(),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
