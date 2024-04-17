import 'package:aasa_emr/features/settings/presentation/providers/medication_provider.dart';
import 'package:aasa_emr/features/user/data/models/settings_model.dart';
import 'package:aasa_emr/features/user/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';
import 'edit_rx_format_screen.dart';
import 'edit_medications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'edit_clinic_recpetionist_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/settings_button_widget.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CustomAppBarWithBackButton(),
              SizedBox(height: 20.h),
              Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 12.h),
              SettingButtonWidget(
                onTap: () {
                  context.read<MedicationProvider>().rxTemplate!.clear();

                  List<RxTemplate> rxTemplate = context.read<UserProvider>().user.settings!.rxTemplates;
                  context.read<MedicationProvider>().addRxTemplates(rxTemplate);

                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EditMedicationsScreen(),
                    ),
                  );
                },
                title: "Edit Medications",
              ),
              SettingButtonWidget(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EditRxFormatScreen(),
                    ),
                  );
                },
                title: "Edit Rx Format",
              ),
              SettingButtonWidget(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                title: "Edit Profile",
              ),
              SettingButtonWidget(
                onTap: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const EditClinicAndReceptionistScreen(),
                    ),
                  );
                },
                title: "Edit Clinic and Receptionist",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
