import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../user/presentation/providers/user_provider.dart';
import '../../providers/patient_vitals_provider.dart';
import 'patient_vital_tile.dart';

class PatientVitalsColumn extends StatelessWidget {
  const PatientVitalsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Patient Vitals",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
              //   child: const Text("Add"),
              // ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    "Field",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Show in Rx",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          Consumer2<UserProvider, PatientVitalsProvider>(builder: (context, userProvider, patientVitalsProvider, _) {
            return ListView.builder(
              itemCount: patientVitalsProvider.allPatientVitals.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PatientVitalFieldTile(
                  vitalName: patientVitalsProvider.allPatientVitals[index],
                  isCheckBoxSelected:
                      patientVitalsProvider.selectedVitals.contains(patientVitalsProvider.allPatientVitals[index]),
                  onCheckboxSelected: (value) {
                    patientVitalsProvider.onChanged(value, patientVitalsProvider.allPatientVitals[index]);
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
