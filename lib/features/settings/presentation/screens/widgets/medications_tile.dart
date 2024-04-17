
import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:provider/provider.dart';

import '../../../../user/data/models/settings_model.dart';

import '../../../../../utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../edit_medicine_screen.dart';

class MedicationsTile extends StatelessWidget {
  const MedicationsTile({
    super.key,
    required this.rxTemplate,
  });

  final RxTemplate rxTemplate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ConstantColors.kTileBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              rxTemplate.condition?.conditionName ?? "-",
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: () {
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
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstantColors.kSecondaryColor,
              ),
              child: const Text("Edit Medication"),
            ),
          ),
        ],
      ),
    );
  }
}
