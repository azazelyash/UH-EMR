import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/universal_loading_widget.dart';
import '../../data/models/appointment.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';

import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import 'widgets/appointment_details_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentInfoScreen extends StatelessWidget {
  const AppointmentInfoScreen({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 128,
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
                    preferredSize: Size.fromHeight(56.h),
                    child: Container(
                      color: ConstantColors.kWhiteColor,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Strings.appointmentsInfo,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                  sliver: SliverToBoxAdapter(
                    child: AppointmentDetailsWidget(
                      appointment: appointment,
                    ),
                  ),
                ),
                // const SliverPadding(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                //   sliver: SliverToBoxAdapter(
                //     child: NoteFromDoctorWidget(),
                //   ),
                // ),
                // const SliverPadding(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                //   sliver: SliverToBoxAdapter(
                //     child: MedsOrderSummaryWidget(),
                //   ),
                // ),
                // const SliverPadding(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                //   sliver: SliverToBoxAdapter(
                //     child: TestsOrderSummaryWidget(),
                //   ),
                // ),
                // const SliverPadding(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                //   sliver: SliverToBoxAdapter(
                //     child: SendRxInOtherLanguage(),
                //   ),
                // ),
              ],
            ),
            if (context.watch<AppointmentProvider>().isLoading) const UniversalLoadingWidget()
          ],
        ),
      ),
    );
  }
}
