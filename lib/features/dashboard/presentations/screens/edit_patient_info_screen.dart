import 'dart:developer';

import 'package:aasa_emr/features/dashboard/presentations/providers/appointment_provider.dart';
import 'package:aasa_emr/features/dashboard/presentations/screens/doctor_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:aasa_emr/common/functions/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aasa_emr/features/dashboard/data/models/patients.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';

class EditPatientInfoScreen extends StatefulWidget {
  const EditPatientInfoScreen({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  State<EditPatientInfoScreen> createState() => _EditPatientInfoScreenState();
}

class _EditPatientInfoScreenState extends State<EditPatientInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  DateTime dateOfBirth = DateTime.now();
  String countryCode = "+91";

  @override
  void initState() {
    super.initState();

    nameController.text = widget.patient.name ?? "-";
    phoneController.text = widget.patient.phone?.phoneNumber ?? "-";
    addressController.text = widget.patient.address ?? "-";
    countryCode = widget.patient.phone?.countryCode ?? "+91";
    dateOfBirth = widget.patient.dob!;
    dobController.text = DateFormat.yMMMd().format(widget.patient.dob!);
    ageController.text = AppFunctions.calculatePatientAge(widget.patient.dob!).toString();
    weightController.text = widget.patient.patientVitals?.weight ?? "-";
    heightController.text = widget.patient.patientVitals?.height ?? "-";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(10.sp),
        child: ElevatedButton(
          onPressed: () async {
            try {
              Patient newPatient = widget.patient.copyWith(
                name: nameController.text,
                phone: Phone(countryCode: countryCode, phoneNumber: phoneController.text),
                dob: dateOfBirth,
                address: addressController.text,
                patientVitals: widget.patient.patientVitals!.copyWith(
                  weight: weightController.text,
                  height: heightController.text,
                ),
              );

              log(newPatient.toJson().toString());

              await context.read<AppointmentProvider>().updatePatientProfile(patient: newPatient);
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(builder: (context) => const DoctorDashboardScreen()),
                (route) => false,
              );
              Utils.showSnackBar(
                context,
                content: "Patient Updated Successfuly",
              );
            } catch (e) {
              if (!mounted) return;
              Utils.showSnackBar(
                context,
                content: "An Error Occured",
              );
            }
          },
          child: const Text("Save Changes"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomAppBarWithBackButton(),
              SizedBox(height: 12.h),
              Text(
                "Edit Patient Info",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
              ),
              SizedBox(height: 10.h),
              IntlPhoneField(
                showCountryFlag: false,
                initialCountryCode: 'IN',
                disableLengthCheck: false,
                controller: phoneController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                dropdownIconPosition: IconPosition.trailing,
                flagsButtonPadding: EdgeInsets.only(left: 12.w),
                dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                languageCode: "en",
                onCountryChanged: (value) {
                  countryCode = value.dialCode;
                },
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  label: Text("Address"),
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: dobController,
                onTap: () async {
                  final value = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1899),
                    lastDate: DateTime.now(),
                  );

                  if (value != null) {
                    dateOfBirth = value;
                    dobController.text = DateFormat.yMMMd().format(value);
                  }
                },
                keyboardType: TextInputType.none,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  label: Text("Date of Birth"),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        label: Text("Age"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextFormField(
                      controller: weightController,
                      decoration: const InputDecoration(
                        label: Text("Weight"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextFormField(
                      controller: heightController,
                      decoration: const InputDecoration(
                        label: Text("Height"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
