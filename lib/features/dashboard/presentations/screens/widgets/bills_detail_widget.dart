import '../../../../../utils/constants/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillDetailsWidget extends StatelessWidget {
  const BillDetailsWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      content: SizedBox(
        width: 560.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  splashRadius: 20,
                  icon: const Icon(Icons.close),
                  color: ConstantColors.kHeadlingColor,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            DottedBorder(
              dashPattern: const [6, 3],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Medicines",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Qty.",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Price",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    const DottedDashedLine(
                      height: 1,
                      width: double.infinity,
                      axis: Axis.horizontal,
                    ),
                    SizedBox(height: 8.h),
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Hydrochloroquinone Hydrochloro 450mg",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "3",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Rs. 300",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const DottedDashedLine(
                      height: 1,
                      width: double.infinity,
                      axis: Axis.horizontal,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Item Total",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Rs. 900",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Taxes and Charges",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Rs. 700",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    const DottedDashedLine(
                      height: 1,
                      width: double.infinity,
                      axis: Axis.horizontal,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Grand Total",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Rs. 1600",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
