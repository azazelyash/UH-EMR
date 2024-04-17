import 'dart:developer';
import 'dart:io';

import 'package:aasa_emr/common/helper/token_manager.dart';
import 'package:aasa_emr/common/helper/utils.dart';
import 'package:aasa_emr/common/widgets/cancel_alert_dialog.dart';
import 'package:aasa_emr/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:aasa_emr/features/auth/presentations/providers/auth_provider.dart';
import 'package:aasa_emr/features/user/data/models/clinic.dart';
import 'package:aasa_emr/features/user/data/models/user_model.dart';
import 'package:aasa_emr/service/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/custom_appbar_with_back_button.dart';
import '../../../../common/widgets/universal_loading_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../user/data/data_source/user_local_data_source.dart';
import '../../../user/presentation/providers/user_provider.dart';
import 'widgets/browse_image_tile.dart';

class EditClinicAndReceptionistScreen extends StatefulWidget {
  const EditClinicAndReceptionistScreen({super.key});

  @override
  State<EditClinicAndReceptionistScreen> createState() => _EditClinicAndReceptionistScreenState();
}

class _EditClinicAndReceptionistScreenState extends State<EditClinicAndReceptionistScreen> {
  final List<EditClinicModel> oldClinics = [];
  final List<EditClinicModel> newClinincs = [];
  final List<EditClinicModel> allClinincs = [];
  final List<Clinic> deletedClinic = [];

  final List<EditReceptionistModel> oldReceptionists = [];
  final List<EditReceptionistModel> newReceptionists = [];
  final List<EditReceptionistModel> allReceptionists = [];
  final List<Receptionist> deletedReceptionist = [];

  @override
  initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    for (Clinic clinic in userProvider.clinics) {
      oldClinics.add(
        EditClinicModel(
          clinic: clinic,
          nameController: TextEditingController(text: clinic.name),
          addressController: TextEditingController(text: clinic.address),
          url: clinic.logo,
        ),
      );
    }
    allClinincs.addAll([...oldClinics]);

    for (var receptionist in userProvider.receptionists) {
      oldReceptionists.add(
        EditReceptionistModel(
          receptionist: receptionist,
          nameController: TextEditingController(text: receptionist.name),
          contactController: TextEditingController(text: receptionist.phone?.phoneNumber),
          emailController: TextEditingController(text: receptionist.email),
        ),
      );
    }
    allReceptionists.addAll([...oldReceptionists]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ConstantColors.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            onPressed: () async {
              Analytics.editClinicAndReceptionist();
              try {
                final userProvider = context.read<UserProvider>();
                final authProvider = context.read<AuthProvider>();
                // final currentUser = userProvider.user;

                final TokenManager tokenManager =
                    TokenManager(sharedPreferences: await SharedPreferences.getInstance());
                final token = await tokenManager.getAccessToken();

                for (var editClinic in oldClinics) {
                  String? url;
                  if (editClinic.imageFile != null) {
                    url = await Utils.uploadFile(editClinic.imageFile!, token!);
                  }
                  await userProvider.updateClinic(
                    editClinic.clinic.copyWith(
                      name: editClinic.nameController.text.trim(),
                      address: editClinic.addressController.text.trim(),
                      logo: url,
                    ),
                  );
                }

                for (var editClinic in newClinincs) {
                  String? url;
                  if (editClinic.imageFile != null) {
                    url = await Utils.uploadFile(editClinic.imageFile!, token!);
                  }

                  await userProvider.createClinic(
                    editClinic.clinic.copyWith(
                      name: editClinic.nameController.text.trim(),
                      address: editClinic.addressController.text.trim(),
                      logo: url,
                    ),
                  );
                }

                for (var clinic in deletedClinic) {
                  await userProvider.deleteClinic(clinic, userProvider.user.id!);
                }

                for (var editReceptionist in oldReceptionists) {
                  await userProvider.updateReceptionist(editReceptionist.receptionist.copyWith(
                    name: editReceptionist.nameController.text.trim(),
                    phone: PhoneModel(
                      phoneNumber: editReceptionist.contactController.text.trim(),
                    ),
                  ));
                }

                for (var editReceptionist in newReceptionists) {
                  try {
                    final user = await userProvider.checkIfUserExists(editReceptionist.emailController.text.trim());
                    if (context.mounted) {
                      await showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "User already exists with the following details",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20.h),
                                Text("Email: ${user.profile?.email}"),
                                Text("Name: ${user.profile?.name}"),
                                Text("Phone Number: ${user.profile?.phone?.phoneNumber}"),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await userProvider.createReceptionist(
                                            editReceptionist.receptionist.copyWith(
                                              id: user.id,
                                              email: user.profile?.email,
                                              name: user.profile?.name,
                                              doctorId: [userProvider.user.id!],
                                              phone: PhoneModel(
                                                phoneNumber: user.profile?.phone?.phoneNumber,
                                              ),
                                            ),
                                          );
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Confirm"),
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
                  } catch (e) {
                    final id = await authProvider.signUp(
                      SignUpUsecaseParams(
                        name: editReceptionist.nameController.text.trim(),
                        email: editReceptionist.emailController.text.trim(),
                        phoneNumber: editReceptionist.contactController.text.trim(),
                        role: 'receptionist',
                        moduleAccess: [],
                      ),
                    );
                    await userProvider.createReceptionist(
                      editReceptionist.receptionist.copyWith(
                        id: id,
                        email: editReceptionist.emailController.text.trim(),
                        name: editReceptionist.nameController.text.trim(),
                        doctorId: [userProvider.user.id!],
                        phone: PhoneModel(
                          phoneNumber: editReceptionist.contactController.text.trim(),
                        ),
                      ),
                    );
                  }
                }
                log(userProvider.user.id!, name: "Doctor Id");
                for (var receptionist in deletedReceptionist) {
                  // await authProvider.deleteUser(receptionist.id!);

                  await userProvider.deleteReceptionist(receptionist, userProvider.user.id!);
                }
                log(userProvider.receptionists.length.toString());
                // deletedReceptionist.clear();
                // newReceptionists.clear();
                await userProvider.getUser();
                // userProvider.getReceptionists();
                await userProvider.getClinics();
                // log(userProvider.receptionists.length.toString());
                if (context.mounted) {
                  Navigator.pop(context);
                  Utils.showSnackBar(context, content: "Profile Updated");
                }
              } catch (e) {
                if (context.mounted) {
                  Utils.showSnackBar(context, content: e.toString());
                }
              }

              // final allClinicIds = [...currentUser.profile!.clinics.map((e) => e.)];
            },
            child: const Text("Save Changes"),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Consumer<UserProvider>(builder: (context, userProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CustomAppBarWithBackButton(),
                    SizedBox(height: 16.h),
                    Text("Edit Clinic and Receptionist", style: Theme.of(context).textTheme.headlineMedium),
                    SizedBox(height: 16.h),
                    // const ClinicWidget(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1, color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Clinic",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    try {
                                      newClinincs.add(
                                        EditClinicModel(
                                          clinic: Clinic(
                                            userDoctor: [
                                              Doctor(
                                                docID: userProvider.user.id,
                                                name: userProvider.user.profile?.name ?? "",
                                              )
                                            ],
                                          ),
                                          nameController: TextEditingController(),
                                          addressController: TextEditingController(),
                                        ),
                                      );
                                      allClinincs.add(
                                        EditClinicModel(
                                          clinic: Clinic(
                                            userDoctor: [
                                              Doctor(
                                                docID: userProvider.user.id,
                                                name: userProvider.user.profile?.name ?? "",
                                              )
                                            ],
                                          ),
                                          nameController: TextEditingController(),
                                          addressController: TextEditingController(),
                                        ),
                                      );
                                      setState(() {});
                                    } catch (e) {
                                      if (context.mounted) {
                                        Utils.showSnackBar(context, content: e.toString());
                                      }
                                    }
                                    // clinicAddressControllers.add(TextEditingController());
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                                  label: const Text("Add"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          const Divider(),
                          ...List.generate(
                            allClinincs.length,
                            (index) => Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => CancelPopupWidget(
                                          content: "Are you sure you want to delete this Clinic?",
                                          confirmButtonFunction: () {
                                            if (newClinincs.isNotEmpty) {
                                              newClinincs.removeAt(allClinincs.length - 1 - index);
                                            } else {
                                              deletedClinic.add(allClinincs[index].clinic);
                                              oldClinics.remove(allClinincs.length - 1 - index);
                                            }

                                            allClinincs.removeAt(index);
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                        ),
                                      );
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (context) => Dialog(
                                      //     child: Padding(
                                      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                      //       child: Column(
                                      //         mainAxisSize: MainAxisSize.min,
                                      //         children: [
                                      //           const Text(
                                      //             "Are you sure you want to delete this Clinic?",
                                      //             style: TextStyle(fontSize: 16),
                                      //           ),
                                      //           SizedBox(
                                      //             height: 20.h,
                                      //           ),
                                      //           Row(
                                      //             children: [
                                      //               Expanded(
                                      //                 child: ElevatedButton(
                                      //                   onPressed: () {
                                      //                     Navigator.pop(context);
                                      //                   },
                                      //                   child: const Text("Cancel"),
                                      //                 ),
                                      //               ),
                                      //               SizedBox(
                                      //                 width: 10.h,
                                      //               ),
                                      //               Expanded(
                                      //                 child: OutlinedButton(
                                      //                   style: OutlinedButton.styleFrom(
                                      //                     side: const BorderSide(color: Colors.red),
                                      //                   ),
                                      //                   onPressed: () {
                                      //                     if (newClinincs.isNotEmpty) {
                                      //                       newClinincs.removeAt(allClinincs.length - 1 - index);
                                      //                     } else {
                                      //                       deletedClinic.add(allClinincs[index].clinic);
                                      //                       oldClinics.remove(allClinincs.length - 1 - index);
                                      //                     }

                                      //                     allClinincs.removeAt(index);
                                      //                     Navigator.pop(context);
                                      //                     setState(() {});
                                      //                   },
                                      //                   child: const Text(
                                      //                     "Delete",
                                      //                     style: TextStyle(color: Colors.red),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                TextFormField(
                                  controller: allClinincs[index].nameController,
                                  onChanged: (value) {
                                    newClinincs[allClinincs.length - 1 - index].nameController.text = value;
                                  },
                                  decoration: const InputDecoration(hintText: "Name"),
                                ),
                                SizedBox(height: 12.h),
                                TextFormField(
                                  controller: allClinincs[index].addressController,
                                  onChanged: (value) {
                                    newClinincs[allClinincs.length - 1 - index].addressController.text = value;
                                  },
                                  decoration: const InputDecoration(hintText: "Address"),
                                ),
                                // SizedBox(height: 12.h),
                                // TextFormField(

                                //   decoration: const InputDecoration(hintText: "Contact"),
                                // ),
                                SizedBox(height: 12.h),
                                BrowseImageTile(
                                  title: "Clinic Logo",
                                  imageUrl: allClinincs[index].url,
                                  pickedImage: allClinincs[index].imageFile,
                                  onBrowsePressed: () async {
                                    final UserLocalDataSource userLocalDataSource = UserLocalDataSource(
                                      imagePicker: ImagePicker(),
                                    );

                                    try {
                                      allClinincs[index].imageFile = await userLocalDataSource.pickImage();
                                      setState(() {});
                                    } catch (e) {
                                      if (context.mounted) {
                                        Utils.showSnackBar(context, content: e.toString());
                                      }
                                    }
                                  },
                                ),
                                // if (index + 1 != userProvider.clinics.length) const Divider(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // const ReceptionistWidget(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1, color: Colors.grey.shade400),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Receptionist",
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    newReceptionists.add(
                                      EditReceptionistModel(
                                          receptionist: Receptionist(),
                                          nameController: TextEditingController(),
                                          contactController: TextEditingController(),
                                          emailController: TextEditingController()),
                                    );
                                    allReceptionists.add(
                                      EditReceptionistModel(
                                          receptionist: Receptionist(),
                                          nameController: TextEditingController(),
                                          contactController: TextEditingController(),
                                          emailController: TextEditingController()),
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  style: ElevatedButton.styleFrom(backgroundColor: ConstantColors.kSecondaryColor),
                                  label: const Text("Add"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          const Divider(),
                          ...List.generate(
                            allReceptionists.length,
                            (index) => Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Receptionist ${index + 1}",
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // newReceptionists.removeAt(index);
                                        // allReceptionists.removeAt(index);

                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "Are you sure you want to delete this Receptionist?",
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: const Text("Cancel"),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.h,
                                                      ),
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          style: OutlinedButton.styleFrom(
                                                            side: const BorderSide(color: Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            if (newReceptionists.isNotEmpty) {
                                                              newReceptionists
                                                                  .removeAt(allReceptionists.length - 1 - index);
                                                            } else {
                                                              deletedReceptionist
                                                                  .add(allReceptionists[index].receptionist);
                                                              oldReceptionists
                                                                  .remove(allReceptionists.length - 1 - index);
                                                            }

                                                            allReceptionists.removeAt(index);
                                                            Navigator.pop(context);

                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                            "Delete",
                                                            style: TextStyle(color: Colors.red),
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
                                      },
                                      splashRadius: 20,
                                      visualDensity: VisualDensity.compact,
                                      color: ConstantColors.kErrorColor,
                                      icon: const Icon(Icons.delete_outlined),
                                    )
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: allReceptionists[index].nameController,
                                  onChanged: (value) {
                                    // if (newReceptionists.isNotEmpty) {
                                    newReceptionists[allReceptionists.length - 1 - index].nameController.text = value;
                                    // }
                                    // else {
                                    //   oldReceptionists[allReceptionists.length - 1 - index].nameController.text = value;
                                    // }
                                  },
                                  decoration: const InputDecoration(hintText: "Name"),
                                ),
                                SizedBox(height: 12.h),
                                TextFormField(
                                  controller: allReceptionists[index].contactController,
                                  onChanged: (value) {
                                    // if (newReceptionists.isNotEmpty) {
                                    newReceptionists[allReceptionists.length - 1 - index].contactController.text =
                                        value;
                                    // } else {
                                    //   oldReceptionists[allReceptionists.length - 1 - index].contactController.text =
                                    //       value;
                                    // }
                                  },
                                  decoration: const InputDecoration(hintText: "Contact"),
                                ),
                                SizedBox(height: 12.h),
                                TextFormField(
                                  controller: allReceptionists[index].emailController,
                                  onChanged: (value) {
                                    newReceptionists[allReceptionists.length - 1 - index].emailController.text = value;
                                    value;
                                  },
                                  decoration: const InputDecoration(hintText: "Email"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            if (context.watch<UserProvider>().isLoading) const UniversalLoadingWidget()
          ],
        ),
      ),
    );
  }
}

class EditClinicModel {
  final Clinic clinic;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final String? url;
  File? imageFile;

  EditClinicModel({
    required this.clinic,
    required this.nameController,
    required this.addressController,
    this.url,
    this.imageFile,
  });
}

class EditReceptionistModel {
  final Receptionist receptionist;
  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController emailController;
  EditReceptionistModel({
    required this.receptionist,
    required this.nameController,
    required this.contactController,
    required this.emailController,
  });
}
