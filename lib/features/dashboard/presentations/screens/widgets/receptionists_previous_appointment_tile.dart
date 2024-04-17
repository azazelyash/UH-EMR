import 'indicator_chip.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ReceptionistsPreviousAppointmentTile extends StatelessWidget {
  const ReceptionistsPreviousAppointmentTile({
    super.key,
    required this.index,
    required this.onTap,
    required this.name,
    required this.date,
    required this.time,
    required this.rxStatus,
    this.rxSoldStatus,
  });

  final int index;
  final VoidCallback onTap;
  final String name;
  final String date;
  final String time;
  final String rxStatus;
  final String? rxSoldStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          decoration: BoxDecoration(
            color: ConstantColors.kTileBackgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                flex: 2,
                child: Text(
                  date,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 6.w),
              Flexible(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IndicatorChip(
                          title: (rxStatus == "sold") ? "Sold" : "Not Sold",
                          showButton: false,
                          color: (rxStatus == "sold") ? Colors.green : Colors.red,
                          icon: (rxStatus == "sold") ? Icons.check_rounded : Icons.close_rounded,
                          backgroundColor: (rxStatus == "sold") ? Colors.green.shade50 : Colors.red.shade50,
                        ),
                        (rxStatus == "sold")
                            ? Padding(
                                padding: EdgeInsets.only(left: 6.sp),
                                child: IndicatorChip(
                                  title: (rxSoldStatus == 'transit') ? "In Transit" : "Delivered",
                                  backgroundColor:
                                      (rxSoldStatus == 'transit') ? Colors.blue.shade50 : Colors.green.shade50,
                                  color: (rxSoldStatus == 'transit') ? ConstantColors.kPrimaryColor : Colors.green,
                                  icon: (rxStatus == 'transit') ? Icons.open_in_new : Icons.open_in_new,
                                  showButton: true,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const Icon(
                      Icons.info_outline,
                      size: 24,
                      color: ConstantColors.kHeadlingColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
