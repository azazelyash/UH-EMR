import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/patients.dart';
import '../../../../user/presentation/providers/user_provider.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import '../../providers/appointment_provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../common/widgets/back_chevron_button.dart';
import '../../../../../common/widgets/expanded_elevated_button.dart';

class StartNewRxWidget extends StatefulWidget {
  const StartNewRxWidget({
    super.key,
    required this.newPatientButton,
    required this.existingPatientFuntion,
  });

  final VoidCallback newPatientButton;
  final Function(Patient?)? existingPatientFuntion;

  @override
  State<StartNewRxWidget> createState() => _StartNewRxWidgetState();
}

class _StartNewRxWidgetState extends State<StartNewRxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: ConstantColors.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Start New Rx",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BackChevronButton(
                onTap: () {
                  context.read<DashboardProvider>().creatRxState = false;
                },
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              color: ConstantColors.kWhiteColor,
              border: Border.all(color: ConstantColors.kHeadlingColor),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: Theme(
              data: ThemeData(
                useMaterial3: false,
              ),
              child: SearchableDropdown.paginated(
                dialogOffset: 40.h,
                hintText: const Text("Search Patient"),
                onChanged: widget.existingPatientFuntion,
                paginatedRequest: (int page, String? searchKey) async {
                  String doctorId;
                  if (context.read<UserProvider>().user.role!.roleName == RoleNames.doctor) {
                    doctorId = context.read<UserProvider>().user.id!;
                  } else {
                    doctorId = context.read<UserProvider>().selectedDoctor!.id!;
                  }
                  final paginatedList = await context.read<AppointmentProvider>().getPatients(
                        doctorId: doctorId,
                        page: page,
                        searchKey: searchKey,
                      );
                  return paginatedList
                      .map(
                        (patient) => SearchableDropdownMenuItem(
                          value: patient,
                          label: patient.name ?? '',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (patient.name != null) ? patient.name.toString() : "-",
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                (patient.phone != null) ? patient.phone!.phoneNumber.toString() : "-",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList();
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(padding: EdgeInsets.symmetric(horizontal: 12.0), child: Text("or")),
              Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: 20.h),
          ExpandedElevatedButton(
            title: "Create New Patient",
            onTap: widget.newPatientButton,
            buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: ConstantColors.kSecondaryColor,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
