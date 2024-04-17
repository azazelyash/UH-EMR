import 'package:aasa_emr/service/analytics.dart';

import '../../../../../common/widgets/settings_button_widget.dart';
import '../../providers/dashboard_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectConsultationTimeWidget extends StatelessWidget {
  const SelectConsultationTimeWidget({
    super.key,
    required this.startNowFunction,
    required this.futureConsultationFunction,
  });

  final VoidCallback startNowFunction;
  final VoidCallback futureConsultationFunction;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start New Rx",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close_rounded),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SettingButtonWidget(
                onTap: () {
                  Analytics.logStartRxNow();
                  startNowFunction();
                },
                title: "Start Consultation Now",
              ),
              SizedBox(height: 4.h),
              SettingButtonWidget(
                onTap: () {
                  Analytics.logStartFutureRx();
                  futureConsultationFunction();
                },
                title: "Create Future Consultation",
              ),
            ],
          ),
        );
      },
    );
  }
}
