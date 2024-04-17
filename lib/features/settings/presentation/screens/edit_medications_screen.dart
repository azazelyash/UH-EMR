import 'package:aasa_emr/features/settings/presentation/screens/edit_medicine_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/medications_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/common/widgets/universal_loading_widget.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:aasa_emr/features/settings/presentation/screens/widgets/add_condition_dialog.dart';

import '../../../../utils/constants/colors.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';

class EditMedicationsScreen extends StatefulWidget {
  const EditMedicationsScreen({super.key});

  @override
  State<EditMedicationsScreen> createState() => _EditMedicationsScreenState();
}

class _EditMedicationsScreenState extends State<EditMedicationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          thickness: 6,
          interactive: true,
          trackVisibility: true,
          radius: const Radius.circular(10),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 180.sp,
                automaticallyImplyLeading: false,
                backgroundColor: ConstantColors.kWhiteColor,
                flexibleSpace: const FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Column(
                      children: [
                        CustomAppBarWithBackButton(),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(120.sp),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit Medications",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 48.h,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ConstantColors.kWhiteColor,
                                    border: Border.all(color: ConstantColors.kHeadlingColor),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                                  child: Theme(
                                    data: ThemeData(useMaterial3: false),
                                    child: Consumer<MedicationProvider>(
                                      builder: (context, medicationProvider, child) {
                                        List<RxTemplate> rxTemplates = medicationProvider.rxTemplate!;
                                        return SearchableDropdown(
                                          dialogOffset: -48.h,
                                          onChanged: (rxTemplate) {
                                            medicationProvider.setLoading(true);
                                            medicationProvider.rxTemplate!.clear();
                                            if (rxTemplate == null) {
                                              List<RxTemplate> list =
                                                  context.read<UserProvider>().user.settings!.rxTemplates;
                                              medicationProvider.resetConditions(list);
                                            }
                                            medicationProvider.setLoading(false);
                                          },
                                          items: rxTemplates
                                              .map(
                                                (rxTemplate) => SearchableDropdownMenuItem(
                                                  value: rxTemplate.condition,
                                                  label: rxTemplate.condition!.conditionName!,
                                                  onTap: () {
                                                    medicationProvider.setLoading(true);
                                                    medicationProvider.rxTemplate!.clear();
                                                    medicationProvider.rxTemplate!.add(rxTemplate);
                                                    medicationProvider.setLoading(false);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                                    child: Text(
                                                      rxTemplate.condition!.conditionName!,
                                                      maxLines: 2,
                                                      style: Theme.of(context).textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          hintText: const Text("Search Condition"),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 48,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      RxTemplate? rxTemplate = await showDialog(
                                        context: context,
                                        builder: (context) => const AddConditionDialog(),
                                      );
                                      setState(() {});

                                      if (context.mounted && rxTemplate != null) {
                                        context.read<MedicationProvider>().emptyAllVariables();
                                        for (var element in rxTemplate.medication) {
                                          context.read<MedicationProvider>().initialiseMeds(element);
                                        }
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => EditMedicineScreen(
                                              rxTemplate: rxTemplate,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: ConstantColors.kSecondaryColor,
                                      side: const BorderSide(
                                        color: ConstantColors.kSecondaryColor,
                                      ),
                                    ),
                                    child: const Text("Add Condition"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: Consumer2<UserProvider, MedicationProvider>(
                  builder: (context, userProvider, medicationProvider, child) {
                    return (medicationProvider.isLoading)
                        ? const UniversalLoadingWidget()
                        : (medicationProvider.rxTemplate == null || medicationProvider.rxTemplate!.isEmpty)
                            ? SliverToBoxAdapter(
                                child: Center(
                                  child: Text(
                                    "No Templates",
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                ),
                              )
                            : SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return MedicationsTile(
                                      rxTemplate: medicationProvider.rxTemplate![index],
                                    );
                                  },
                                  childCount: medicationProvider.rxTemplate!.length,
                                  addRepaintBoundaries: false,
                                  addAutomaticKeepAlives: false,
                                ),
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
