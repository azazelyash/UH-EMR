import '../../../../common/constants/dummy_list_of_doctors.dart';
import 'receptionists_dashboard_screen.dart';
import 'widgets/clinic_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseDoctorScreen extends StatelessWidget {
  const ChooseDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(140.sp),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h, bottom: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Doctor",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 12.h),
                      AvatarButton(
                        selectAll: true,
                        clinicName: "Select All",
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const ReceptionistsDashboardScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: Scrollbar(
            thickness: 6,
            interactive: true,
            trackVisibility: true,
            radius: const Radius.circular(10),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  sliver: SliverList.builder(
                    itemCount: listOfDoctors.length,
                    itemBuilder: (context, index) {
                      return AvatarButton(
                        clinicName: listOfDoctors[index],
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => const ReceptionistsDashboardScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
