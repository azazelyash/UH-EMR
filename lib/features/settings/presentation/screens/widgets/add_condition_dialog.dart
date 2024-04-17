import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/common/widgets/expanded_elevated_button.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';

class AddConditionDialog extends StatefulWidget {
  const AddConditionDialog({
    super.key,
  });

  @override
  State<AddConditionDialog> createState() => _AddConditionDialogState();
}

class _AddConditionDialogState extends State<AddConditionDialog> {
  TextEditingController conditionNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    conditionNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      content: SizedBox(
        width: 560.w,
        child: Consumer2<MedicationProvider, UserProvider>(
          builder: (context, medicationProvider, userProvider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add new condition"),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      splashRadius: 20,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: conditionNameController,
                  decoration: const InputDecoration(
                    label: Text("Condition Name"),
                  ),
                ),
                SizedBox(height: 12.h),
                ExpandedElevatedButton(
                  onTap: () async {
                    try {
                      Analytics.addNewCondition(conditionName: conditionNameController.text);
                      User user = userProvider.user;

                      RxTemplate newRxTemplate = RxTemplate(
                          condition: Condition(
                        conditionName: conditionNameController.text,
                      ));

                      medicationProvider.addNewCondition(newRxTemplate);

                      User newUser = user.copyWith(
                        settings: user.settings!.copyWith(
                          rxTemplates: medicationProvider.rxTemplate,
                        ),
                      );
                      await medicationProvider.updateUser(newUser);
                      if (!mounted) return;
                      await userProvider.getUser();
                      if (!mounted) return;

                      Navigator.of(context).pop(newRxTemplate);
                    } catch (e) {
                      Utils.showSnackBar(
                        context,
                        content: e.toString(),
                      );
                    }
                  },
                  title: "Save and Continue",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
