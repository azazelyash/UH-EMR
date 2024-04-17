import '../../../../user/data/models/user_model.dart';
import '../../../../../utils/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../user/presentation/providers/user_provider.dart';

class DegreeWidget extends StatefulWidget {
  const DegreeWidget({
    super.key,
  });

  @override
  State<DegreeWidget> createState() => _DegreeWidgetState();
}

class _DegreeWidgetState extends State<DegreeWidget> {
  List<TextEditingController> degreeControllers = [];
  List<TextEditingController> collegeControllers = [];
  List<TextEditingController> completionYearControllers = [];

  @override
  void initState() {
    final user = context.read<UserProvider>().user;
    if (user.profile == null) return;
    initializeControllers(user);
    super.initState();
  }

  @override
  void deactivate() {
    final List<DegreeModel> degrees = context.read<UserProvider>().user.profile?.degrees ?? [];
    disposeControllers(degrees);
    super.deactivate();
  }

  void initializeControllers(User? user) {
    if (user!.profile!.degrees.isNotEmpty) {
      for (int i = 0; i < user.profile!.degrees.length; i++) {
        degreeControllers.add(TextEditingController(text: user.profile!.degrees[i].degreeName));
        collegeControllers.add(TextEditingController(text: user.profile!.degrees[i].collegeName));
        completionYearControllers.add(TextEditingController(text: user.profile!.degrees[i].passingYear));
      }
    }
  }

  void disposeControllers(List<DegreeModel> degrees) {
    if (context.read<UserProvider>().user.profile?.degrees.isNotEmpty ?? false) {
      for (int i = 0; i < degrees.length; i++) {
        degreeControllers[i].dispose();
        collegeControllers[i].dispose();
        completionYearControllers[i].dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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

        List<DegreeModel> degrees = [];
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
                    onPressed: () {},
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
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}
