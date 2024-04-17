import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/common/widgets/universal_loading_widget.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../user/data/models/settings_model.dart';
import 'widgets/edit_grade_level_medicine.dart';

class EditMedicineScreen extends StatefulWidget {
  const EditMedicineScreen({super.key, required this.rxTemplate});

  final RxTemplate rxTemplate;
  @override
  State<EditMedicineScreen> createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 196,
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
                      preferredSize: const Size.fromHeight(120),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.rxTemplate.condition?.conditionName ?? "-",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(height: 12.h),
                            TabBar(
                              splashBorderRadius: BorderRadius.circular(12),
                              controller: _tabController,
                              indicator: BoxDecoration(
                                color: const Color(0xffE9FDF3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelColor: ConstantColors.kSecondaryColor,
                              unselectedLabelColor: Colors.black38,
                              padding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              indicatorPadding: EdgeInsets.zero,
                              indicatorSize: TabBarIndicatorSize.tab,
                              physics: const BouncingScrollPhysics(),
                              labelStyle: Theme.of(context).textTheme.titleMedium,
                              // tabs: widget.rxTemplate.medication
                              //     .map((e) => Tab(
                              //           child: Text(e.grade ?? "-"),
                              //         ))
                              //     .toList()
                              tabs: const <Widget>[
                                Tab(text: "Grade 1"),
                                Tab(text: "Grade 2"),
                                Tab(text: "Grade 3"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  EditGradeLevelMedicine(grade: "grade 1"),
                  EditGradeLevelMedicine(grade: "grade 2"),
                  EditGradeLevelMedicine(grade: "grade 3"),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Consumer2<MedicationProvider, UserProvider>(
            builder: (context, medicationProvider, userProvider, child) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ConstantColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    User user = userProvider.user;

                    MedicationModel grade1MedicineModel = MedicationModel(
                      grade: "Grade 1",
                      medicineDetails: medicationProvider.updateMedicine("Grade 1"),
                    );
                    MedicationModel grade2MedicineModel = MedicationModel(
                      grade: "Grade 2",
                      medicineDetails: medicationProvider.updateMedicine("Grade 2"),
                    );
                    MedicationModel grade3MedicineModel = MedicationModel(
                      grade: "Grade 3",
                      medicineDetails: medicationProvider.updateMedicine("Grade 3"),
                    );

                    List<MedicationModel> medication = [];

                    medication.add(grade1MedicineModel);
                    medication.add(grade2MedicineModel);
                    medication.add(grade3MedicineModel);

                    Condition condition = Condition(
                      id: widget.rxTemplate.condition!.id,
                      conditionName: widget.rxTemplate.condition!.conditionName,
                    );

                    Analytics.editCondition(condition: widget.rxTemplate.condition);

                    final updatedUser = user.copyWith(
                      settings: user.settings!.copyWith(
                          rxTemplates: user.settings!.rxTemplates.map((data) {
                        if (data.condition!.conditionName == widget.rxTemplate.condition!.conditionName) {
                          return data.copyWith(
                            medication: medication,
                            condition: condition,
                            id: widget.rxTemplate.id,
                          );
                        } else {
                          return data;
                        }
                      }).toList()),
                    );

                    try {
                      await medicationProvider.updateUser(updatedUser);
                      await userProvider.getUser();
                      if (context.mounted) {
                        Utils.showSnackBar(
                          context,
                          content: "Updated",
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Utils.showSnackBar(
                          context,
                          content: e.toString(),
                        );
                      }
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              );
            },
          ),
        ),
        if (context.watch<UserProvider>().isLoading) const UniversalLoadingWidget()
      ],
    );
  }
}
