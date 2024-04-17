import 'dart:developer';

import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/common/widgets/universal_loading_widget.dart';
import 'package:aasa_emr/features/dashboard/data/models/appointment.dart';
import 'package:aasa_emr/features/rx_screen/presentation/screens/create_draft_rx_screen.dart';
import 'package:aasa_emr/features/rx_screen/presentation/screens/widgets/patient_details_widget.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';

import '../../../dashboard/data/models/patients.dart';
import '../providers/rx_provider.dart';
import 'widgets/condition_tile_widget.dart';

class PatientRxScreen extends StatefulWidget {
  const PatientRxScreen({
    super.key,
    required this.patient,
    required this.appointment,
    required this.selectedSymptoms,
  });

  final Patient patient;
  final Appointment appointment;
  final List<String?>? selectedSymptoms;

  @override
  State<PatientRxScreen> createState() => _PatientRxScreenState();
}

class _PatientRxScreenState extends State<PatientRxScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<RxProvider>().getConditions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          thickness: 6,
          interactive: true,
          trackVisibility: true,
          radius: const Radius.circular(10),
          child: Consumer2<UserProvider, RxProvider>(
            builder: (context, userProvider, rxProvider, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 560.sp,
                    automaticallyImplyLeading: false,
                    backgroundColor: ConstantColors.kWhiteColor,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const CustomAppBarWithBackButton(),
                            const SizedBox(height: 16),
                            PatientDetailsWidget(
                              patient: widget.patient,
                              visit: widget.appointment.visit,
                              selectedSymptoms: widget.selectedSymptoms,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(100.h),
                      child: Container(
                        color: ConstantColors.kWhiteColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              Strings.selectPatientConditions,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              decoration: BoxDecoration(
                                color: ConstantColors.kWhiteColor,
                                border: Border.all(color: ConstantColors.kHeadlingColor),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                              child: Theme(
                                data: ThemeData(useMaterial3: false),
                                child: SearchableDropdown(
                                  dialogOffset: -48.h,
                                  onChanged: (condition) {
                                    rxProvider.setLoading(true);
                                    rxProvider.rxTemplate.clear();
                                    if (condition == null) {
                                      rxProvider.getConditions(context);
                                      log(rxProvider.rxTemplate.toString());
                                    }
                                    rxProvider.setLoading(false);
                                  },
                                  items: userProvider.user.settings!.rxTemplates
                                      .map(
                                        (condition) => SearchableDropdownMenuItem(
                                          value: condition.condition,
                                          label: condition.condition!.conditionName!,
                                          onTap: () {
                                            rxProvider.setLoading(true);
                                            rxProvider.rxTemplate.clear();
                                            rxProvider.rxTemplate.add(condition);
                                            rxProvider.setLoading(false);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 4.h),
                                            child: Text(
                                              condition.condition!.conditionName!,
                                              maxLines: 2,
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  hintText: const Text("Search Condition"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: (rxProvider.rxTemplate.isNotEmpty)
                        ? SliverList.builder(
                            itemCount: rxProvider.rxTemplate.length,
                            itemBuilder: (context, index) {
                              return ConditionTileWidget(
                                condition: rxProvider.rxTemplate[index],
                                gradeOneValue: "Grade 1",
                                gradeTwoValue: "Grade 2",
                                gradeThreeValue: "Grade 3",
                                conditionName: rxProvider.rxTemplate[index].condition!.conditionName!,
                              );
                            },
                          )
                        : SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Center(
                                child: Text(
                                  "No Conditions Saved",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Consumer<RxProvider>(
        builder: (context, rxProvider, child) {
          return Container(
            color: ConstantColors.kWhiteColor,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (rxProvider.selectedConditions.isEmpty) {
                  Utils.showSnackBar(
                    context,
                    content: "Please Select a condition",
                  );
                  return;
                }

                rxProvider.noteControllers.clear();
                rxProvider.prescribedMedicines.clear();
                rxProvider.initialiseMeds();

                Analytics.logCreateDraftRx();

                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => DraftRxScreen(
                      patient: widget.patient,
                      appointment: widget.appointment,
                      selectedSymptoms: widget.selectedSymptoms,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantColors.kSecondaryColor,
              ),
              child: Text(Strings.createDraftRx),
            ),
          );
        },
      ),
    );
  }
}
