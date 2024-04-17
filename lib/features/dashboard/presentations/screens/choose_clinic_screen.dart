import 'dart:developer';

import 'package:aasa_emr/features/dashboard/presentations/screens/receptionists_dashboard_screen.dart';
import 'package:aasa_emr/features/settings/presentation/screens/edit_clinic_recpetionist_screen.dart';
import 'package:aasa_emr/features/settings/presentation/screens/settings_screen.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/helper/utils.dart';
import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../auth/presentations/providers/auth_provider.dart';
import '../../../auth/presentations/screens/login_screen.dart';
import '../../../user/presentation/providers/user_provider.dart';
import 'doctor_dashboard_screen.dart';
import 'widgets/clinic_list_tile.dart';

class ChooseClinicScreen extends StatefulWidget {
  const ChooseClinicScreen({super.key});

  @override
  State<ChooseClinicScreen> createState() => _ChooseClinicScreenState();
}

class _ChooseClinicScreenState extends State<ChooseClinicScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    void userIdListeners() {
      if (userProvider.user.id != null) {
        getClinics();
        getDropdownValues();
        userProvider.removeListener(userIdListeners);
      }
    }

    userProvider.addListener(userIdListeners);
    // WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
    //   getReceptionists();
    // });
  }

  void getClinics() async {
    try {
      await context.read<UserProvider>().getClinics(informListenersAtStart: false);
    } catch (e) {
      if (!mounted) return;
      Utils.showSnackBar(
        context,
        content: e.toString(),
      );
    } finally {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    }
  }

  void getDropdownValues() async {
    try {
      await context.read<UserProvider>().getDropdownValues(informListenersAtStart: false);
    } catch (e) {
      if (!mounted) return;
      Utils.showSnackBar(
        context,
        content: e.toString(),
      );
    } finally {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    }
  }

  void getReceptionists() async {
    try {
      await context.read<UserProvider>().getReceptionists();
    } catch (e) {
      if (!mounted) return;
      Utils.showSnackBar(context, content: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final role = userProvider.user.role;
    final clinics = userProvider.clinics;
    return Scaffold(
      body: SafeArea(
        child: context.watch<UserProvider>().isLoading
            ? const UniversalLoadingWidget()
            : clinics.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "No Cinics to choose",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(height: 100.h),
                        if (role != null && role.roleName == RoleNames.receptionist)
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  try {
                                    await context.read<AuthProvider>().signOut();

                                    if (context.mounted) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                    await Future.delayed(const Duration(seconds: 1));
                                    if (context.mounted) {
                                      context.read<UserProvider>().makeUserEmpty();
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                child: const Text("Logout"),
                              ),
                            ),
                          ),
                        if (role != null && role.roleName == RoleNames.doctor)
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DoctorDashboardScreen(),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SettingsScreen(),
                                    ),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditClinicAndReceptionistScreen(),
                                    ),
                                  );
                                },
                                child: const Text("Add Clinics"),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        pinned: true,
                        floating: true,
                        expandedHeight: 0,
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(150.sp),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h, bottom: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Choose Clinic",
                                    style: Theme.of(context).textTheme.headlineLarge,
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                // if (clinics.isNotEmpty)
                                AvatarButton(
                                  selectAll: true,
                                  clinicName: "Select All",
                                  onTap: () {
                                    final UserProvider userProvider = context.read<UserProvider>();
                                    userProvider.selectClinic(userProvider.clinics);
                                    if (userProvider.user.role!.roleName == RoleNames.doctor) {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => const DoctorDashboardScreen(),
                                        ),
                                      );
                                    } else if (userProvider.user.role!.roleName == RoleNames.receptionist) {
                                      if (userProvider.user.listOfDoctors!.isNotEmpty) {
                                        userProvider.doctorsAssociatedWithSelectedClinic = userProvider.user.listOfDoctors!
                                            .where((doctor) => doctor.profile!.clinics.any((clinicId) => userProvider.selectedClinics.any(
                                                  (clinic) => clinic.id.toString() == clinicId,
                                                )))
                                            .toList();
                                      }
                                      userProvider.selectedDoctor = userProvider.doctorsAssociatedWithSelectedClinic![0];
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => const ReceptionistsDashboardScreen(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    body: Stack(
                      alignment: Alignment.center,
                      children: [
                        Scrollbar(
                          thickness: 6,
                          interactive: true,
                          trackVisibility: true,
                          radius: const Radius.circular(10),
                          child: CustomScrollView(
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                sliver: Consumer<UserProvider>(builder: (context, userProvider, child) {
                                  final clinics = userProvider.clinics;
                                  return SliverList.builder(
                                    itemCount: clinics.length,
                                    itemBuilder: (context, index) {
                                      return AvatarButton(
                                        clinicName: clinics[index].name ?? "-",
                                        logo: clinics[index].logo,
                                        onTap: () {
                                          Analytics.chooseClinic(clinic: clinics[index]);
                                          userProvider.selectClinic([clinics[index]]);

                                          if (userProvider.user.role!.roleName == RoleNames.doctor) {
                                            Navigator.of(context).push(
                                              CupertinoPageRoute(
                                                builder: (context) => const DoctorDashboardScreen(),
                                              ),
                                            );
                                          } else if (userProvider.user.role!.roleName == RoleNames.receptionist) {
                                            if (userProvider.user.listOfDoctors!.isEmpty) {
                                              Utils.showSnackBar(context, content: "No Doctors Added");
                                            } else {
                                              if (userProvider.user.listOfDoctors!.isNotEmpty) {
                                                userProvider.doctorsAssociatedWithSelectedClinic = userProvider.user.listOfDoctors!
                                                    .where((doctor) => doctor.profile!.clinics.any((clinicId) => userProvider.selectedClinics.any(
                                                          (clinic) => clinic.id.toString() == clinicId,
                                                        )))
                                                    .toList();
                                              }
                                              userProvider.selectedDoctor = userProvider.doctorsAssociatedWithSelectedClinic![0];
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (context) => const ReceptionistsDashboardScreen(),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        if (context.watch<UserProvider>().isLoading) const UniversalLoadingWidget()
                      ],
                    ),
                  ),
      ),
    );
  }
}
