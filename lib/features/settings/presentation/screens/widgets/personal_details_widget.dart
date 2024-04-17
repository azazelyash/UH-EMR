import '../../../../user/presentation/providers/user_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalDetailsWidget extends StatefulWidget {
  const PersonalDetailsWidget({
    super.key,
  });

  @override
  State<PersonalDetailsWidget> createState() => _PersonalDetailsWidgetState();
}

class _PersonalDetailsWidgetState extends State<PersonalDetailsWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController medicalIdController = TextEditingController();
  final TextEditingController mrnController = TextEditingController();
  final TextEditingController councilController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    final user = context.read<UserProvider>().user;
    nameController.text = user.profile?.name ?? '';
    specializationController.text = user.profile?.specialization ?? '';
    medicalIdController.text = user.profile?.medicalId ?? '';
    mrnController.text = user.profile?.mrn ?? '';
    councilController.text = user.profile?.council ?? '';
    if (user.profile?.dob != null) {
      dobController.text = DateFormat.yMd().format(user.profile!.dob!);
    }
    super.initState();
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

  DateTime? dob;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              decoration: const InputDecoration(hintText: "Name"),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: specializationController,
              decoration: const InputDecoration(hintText: "Specialization"),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: medicalIdController,
              decoration: const InputDecoration(hintText: "Medical ID"),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: mrnController,
              decoration: const InputDecoration(hintText: "MRN"),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: councilController,
              decoration: const InputDecoration(hintText: "Council"),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: dobController,
              onTap: () async {
                await showDatePicker(
                  context: context,
                  lastDate: DateTime.now(),
                  firstDate: DateTime(1899),
                );
              },
              keyboardType: TextInputType.none,
              enableInteractiveSelection: false,
              decoration: const InputDecoration(hintText: "Date Of Birth"),
            ),
          ],
        );
      }),
    );
  }
}
