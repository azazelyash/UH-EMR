import 'dart:developer';
import '../../providers/appointment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import 'start_new_rx_widget.dart';
import 'create_rx_form_bottom_sheet.dart';
import 'select_consultation_time_widget.dart';

class StartRxBottomSheet extends StatelessWidget {
  const StartRxBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, child) {
        return AnimatedCrossFade(
          firstChild: SelectConsultationTimeWidget(
            startNowFunction: () {
              dashboardProvider.startConsulationNow = true;
              dashboardProvider.creatRxState = true;
            },
            futureConsultationFunction: () {
              dashboardProvider.startConsulationNow = false;
              dashboardProvider.creatRxState = true;
            },
          ),
          secondChild: dashboardProvider.creatRxState
              ? AnimatedCrossFade(
                  firstChild: StartNewRxWidget(
                    newPatientButton: () {
                      log("Start Consultation Now: ${dashboardProvider.startConsulationNow}");
                      dashboardProvider.createNewPatient = true;
                      dashboardProvider.fillDetailsState = true;
                    },
                    existingPatientFuntion: (patient) {
                      if (patient == null) return;
                      context.read<AppointmentProvider>().selectedPatient = patient;
                      dashboardProvider.createNewPatient = false;
                      dashboardProvider.fillDetailsState = true;
                    },
                  ),
                  secondChild: dashboardProvider.fillDetailsState ? const CreateRxFormBottomSheet() : const SizedBox(),
                  crossFadeState: dashboardProvider.fillDetailsState ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                )
              : const SizedBox(),
          crossFadeState: dashboardProvider.creatRxState ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
