import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/dashboard/data/models/rx_model.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../common/widgets/expanded_elevated_button.dart';
import '../../../../common/widgets/send_rx_in_other_language.dart';
import '../../../../common/widgets/note_from_doctor_widget.dart';
import 'preview_rx_screen.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteFormalities extends StatelessWidget {
  const CompleteFormalities({
    super.key,
    required this.name,
    required this.date,
    required this.time,
  });

  final String name;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 136.sp,
              automaticallyImplyLeading: false,
              backgroundColor: ConstantColors.kWhiteColor,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: const Column(
                    children: [
                      CustomAppBarWithBackButton(),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(54.h),
                child: Container(
                  color: ConstantColors.kWhiteColor,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Complete Formalitiess",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: Colors.grey.shade400),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Strings.patientDetails,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            "${Strings.visit} Second",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: ConstantColors.kSecondaryColor,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Patient Name"),
                          Text("Contact"),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              "+91 95846 26486",
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: <Widget>[
                          const Text("Diagnosed By:"),
                          SizedBox(width: 8.w),
                          Text(
                            "Dr. Sushant Malhotra",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      ExpandedElevatedButton(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => PreviewRxScreen(
                                rxModel: RxModel(),
                                appointment: Appointment(),
                              ),
                            ),
                          );
                        },
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.kSecondaryColor,
                        ),
                        title: "View Rx and Lab Report",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
              sliver: const SliverToBoxAdapter(
                child: NoteFromDoctorWidget(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
              sliver: const SliverToBoxAdapter(
                child: SendRxInOtherLanguage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
