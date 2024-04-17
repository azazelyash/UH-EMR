import 'package:aasa_emr/common/constants/intake_constants.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'consumption_indicator.dart';

class RxPreviewMedicineTileWidget extends StatelessWidget {
  const RxPreviewMedicineTileWidget({
    super.key,
    required this.medType,
    required this.medName,
    required this.noOfDays,
    required this.frequency,
    required this.foodTiming,
    required this.intake,
    required this.doctorNote,
  });

  final String? doctorNote;
  final String? medType;
  final String? medName;
  final String? noOfDays;
  final String? frequency;
  final String? foodTiming;
  final List<String>? intake;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          const DottedDashedLine(
            height: 1,
            width: double.infinity,
            axis: Axis.horizontal,
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            medType ?? "-",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          flex: 3,
                          child: Text(
                            medName ?? "-",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConsumptionIndicatorWidget(
                          morning: intake!.contains(IntakeConstants.morning),
                          noon: intake!.contains(IntakeConstants.noon),
                          night: intake!.contains(IntakeConstants.night),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            foodTiming ?? "-",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      intake!.join(", "),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            noOfDays ?? "-",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          flex: 2,
                          child: Text(
                            frequency ?? "-",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      doctorNote ?? "-",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
