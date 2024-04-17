import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/browse_image_tile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:aasa_emr/common/helper/token_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aasa_emr/features/user/data/data_source/user_local_data_source.dart';

import '../../../../utils/constants/colors.dart';
import '../../../user/data/models/user_model.dart';
import '../../../user/presentation/providers/user_provider.dart';
import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../../common/widgets/custom_appbar_with_back_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String countryCode = "+91";
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController medicalIdController = TextEditingController();
  final TextEditingController mrnController = TextEditingController();
  final TextEditingController councilController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final List<TextEditingController> degreeControllers = [];
  final List<TextEditingController> collegeControllers = [];
  final List<TextEditingController> completionYearControllers = [];
  List<DegreeModel> degrees = [];
  DateTime? dob;
  File? pickedPhoto;
  File? pickedSign;

  @override
  void initState() {
    final user = context.read<UserProvider>().user;
    nameController.text = user.profile?.name ?? '';
    specializationController.text = user.profile?.specialization ?? '';
    medicalIdController.text = user.profile?.medicalId ?? '';
    mrnController.text = user.profile?.mrn ?? '';
    councilController.text = user.profile?.council ?? '';
    emailController.text = user.profile?.email ?? '';
    addressController.text = user.profile?.address ?? '';
    phoneController.text = user.profile?.phone?.phoneNumber ?? '';
    countryCode = user.profile?.phone?.countryCode ?? '';
    if (user.profile?.dob != null) {
      dob = user.profile!.dob;
      dobController.text = DateFormat.yMMMd().format(user.profile!.dob!);
    }
    if (user.profile!.degrees.isNotEmpty) {
      for (int i = 0; i < user.profile!.degrees.length; i++) {
        degreeControllers.add(TextEditingController(text: user.profile!.degrees[i].degreeName));
        collegeControllers.add(TextEditingController(text: user.profile!.degrees[i].collegeName));
        completionYearControllers.add(TextEditingController(text: user.profile!.degrees[i].passingYear));
      }
    }
    super.initState();
  }

  @override
  void deactivate() {
    final user = context.read<UserProvider>().user;
    final List<DegreeModel> degrees = context.read<UserProvider>().user.profile?.degrees ?? [];
    if (user.profile?.degrees.isNotEmpty ?? false) {
      for (int i = 0; i < degrees.length; i++) {
        degreeControllers[i].dispose();
        collegeControllers[i].dispose();
        completionYearControllers[i].dispose();
      }
    }
    super.deactivate();
  }

  @override
  void dispose() {
    nameController.dispose();
    specializationController.dispose();
    medicalIdController.dispose();
    mrnController.dispose();
    councilController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomAppBarWithBackButton(),
                  SizedBox(height: 16.h),
                  Text("Edit Profile", style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 16.h),
                  // const PersonalDetailsWidget(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Consumer<UserProvider>(builder: (context, userProvider, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Personal Details",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(label: Text("Name")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            enabled: false,
                            controller: emailController,
                            decoration: const InputDecoration(label: Text("Email")),
                          ),
                          SizedBox(height: 12.h),
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
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: addressController,
                            decoration: const InputDecoration(label: Text("Address")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: specializationController,
                            decoration: const InputDecoration(label: Text("Specialisation")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: medicalIdController,
                            decoration: const InputDecoration(label: Text("Medical Id")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: mrnController,
                            decoration: const InputDecoration(label: Text("MRN")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: councilController,
                            decoration: const InputDecoration(label: Text("Council")),
                          ),
                          SizedBox(height: 12.h),
                          TextFormField(
                            controller: dobController,
                            decoration: const InputDecoration(label: Text("Date of Birth")),
                            onTap: () async {
                              dob = await showDatePicker(
                                context: context,
                                lastDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                              );
                              if (dob != null) {
                                dobController.text = DateFormat.yMMMd().format(dob!);
                              }
                            },
                            keyboardType: TextInputType.none,
                            enableInteractiveSelection: false,
                          ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 16.h),
                  // const DegreeWidget(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Consumer<UserProvider>(builder: (context, userProvider, child) {
                      // bool userIsNullOrHasNoDegree = userProvider.user == null ||
                      //     userProvider.user!.profile == null ||
                      //     userProvider.user!.profile!.degrees.isEmpty;
                      bool userHasDegrees = userProvider.user.profile != null || userProvider.user.profile!.degrees.isNotEmpty;

                      if (userHasDegrees) {
                        degrees = userProvider.user.profile!.degrees;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Degrees",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    degrees.add(DegreeModel());
                                    degreeControllers.add(TextEditingController());
                                    collegeControllers.add(TextEditingController());
                                    completionYearControllers.add(TextEditingController());
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                                  label: const Text("Add"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          if (userHasDegrees)
                            ...List.generate(
                              degrees.length,
                              (index) => Column(
                                children: [
                                  TextFormField(
                                    controller: degreeControllers[index],
                                    decoration: const InputDecoration(hintText: "Degree"),
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFormField(
                                    controller: collegeControllers[index],
                                    decoration: const InputDecoration(hintText: "College"),
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFormField(
                                    controller: completionYearControllers[index],
                                    decoration: const InputDecoration(hintText: "Completion Year"),
                                  ),
                                  SizedBox(height: 10.h),
                                  const Divider(),
                                  SizedBox(height: 10.h)
                                ],
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  SizedBox(height: 16.h),
                  // const PracticalExperience(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Practical Experience",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 12.h),
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Practical Experience"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // const PhotoSignatureWidget(),
                  //TODO: Finish Edit Photo and Signature
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                    ),
                    child: Consumer<UserProvider>(
                        child: Text(
                          "Photos & Signatures",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        builder: (context, userProvider, child) {
                          final user = userProvider.user;
                          final docPhoto = user.profile?.docPhoto;
                          final signaturePhoto = user.profile?.docSign;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              child!,
                              SizedBox(height: 12.h),
                              BrowseImageTile(
                                title: "Photo",
                                imageUrl: docPhoto,
                                pickedImage: pickedPhoto,
                                onBrowsePressed: () async {
                                  final UserLocalDataSource userLocalDataSource = UserLocalDataSource(
                                    imagePicker: ImagePicker(),
                                  );

                                  try {
                                    pickedPhoto = await userLocalDataSource.pickImage();
                                    setState(() {});
                                  } catch (e) {
                                    if (context.mounted) {
                                      Utils.showSnackBar(
                                        context,
                                        content: e.toString(),
                                      );
                                    }
                                  }
                                },
                              ),
                              BrowseImageTile(
                                title: "Signature",
                                imageUrl: signaturePhoto,
                                pickedImage: pickedSign,
                                onBrowsePressed: () async {
                                  final UserLocalDataSource userLocalDataSource = UserLocalDataSource(
                                    imagePicker: ImagePicker(),
                                  );

                                  try {
                                    pickedSign = await userLocalDataSource.pickImage();
                                    setState(() {});
                                  } catch (e) {
                                    if (context.mounted) {
                                      Utils.showSnackBar(
                                        context,
                                        content: e.toString(),
                                      );
                                    }
                                  }
                                },
                              ),
                              // const BrowseImageTile(
                              //   title: "Logo",
                              // ),
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          if (context.watch<UserProvider>().isLoading) const UniversalLoadingWidget()
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ConstantColors.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: () async {
              Analytics.editProfile();
              final name = nameController.text.trim();
              final address = addressController.text.trim();
              final phone = PhoneModel(
                countryCode: countryCode,
                phoneNumber: phoneController.text.trim(),
              );
              final specialization = specializationController.text.trim();
              final medicalId = medicalIdController.text.trim();
              final mrn = mrnController.text.trim();
              final council = councilController.text.trim();
              final userProvider = context.read<UserProvider>();
              final currentUser = userProvider.user;
              final List<DegreeModel> newDegrees = [];
              for (int i = 0; i < degrees.length; i++) {
                newDegrees.add(
                  DegreeModel(collegeName: collegeControllers[i].text, degreeName: degreeControllers[i].text, passingYear: completionYearControllers[i].text),
                );
              }

              String? pickedPhotoUrl;
              String? pickedSignUrl;

              if (pickedPhoto != null || pickedSign != null) {
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                final tokenManager = TokenManager(sharedPreferences: sharedPreferences);
                try {
                  final token = await tokenManager.getAccessToken();
                  if (pickedPhoto != null) {
                    pickedPhotoUrl = await Utils.uploadFile(pickedPhoto!, token!);
                  }
                  if (pickedSign != null) {
                    pickedSignUrl = await Utils.uploadFile(pickedSign!, token!);
                  }
                } catch (e) {
                  if (context.mounted) {
                    Utils.showSnackBar(
                      context,
                      content: e.toString(),
                    );
                  }
                  return;
                }
              }

              final updateUser = currentUser.copyWith(
                profile: currentUser.profile?.copyWith(
                  mrn: mrn,
                  dob: dob,
                  name: name,
                  phone: phone,
                  council: council,
                  address: address,
                  degrees: newDegrees,
                  medicalId: medicalId,
                  docSign: pickedSignUrl,
                  docPhoto: pickedPhotoUrl,
                  specialization: specialization,
                ),
              );
              try {
                await userProvider.updateUser(updateUser);
                userProvider.getUser();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Updated")));
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: const Text("Save Changes"),
          ),
        ),
      ),
    );
  }
}
