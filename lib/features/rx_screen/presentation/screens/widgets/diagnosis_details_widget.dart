import 'package:aasa_emr/features/user/data/models/settings_model.dart';

import '../../providers/rx_provider.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'diagnosis_condition_tile_widget.dart';
import 'package:provider/provider.dart';

class DiagnosisDetailWidget extends StatelessWidget {
  const DiagnosisDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      padding: const EdgeInsets.all(10),
      child: Consumer<RxProvider>(
        builder: (context, rxProvider, child) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      Strings.diagnosis,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.edit_rounded,
                        size: 16,
                      ),
                      label: Text(Strings.edit),
                      style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        Strings.num,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        Strings.conditions,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        Strings.grade,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rxProvider.selectedConditions.length,
                itemBuilder: (context, index) {
                  MapEntry<RxTemplate, String> data = rxProvider.selectedConditions.entries.elementAt(index);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: DiagnosisConditionTileWidget(
                      index: index,
                      condition: data.key,
                      grade: data.value,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
