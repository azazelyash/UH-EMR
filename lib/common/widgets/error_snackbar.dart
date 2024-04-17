import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class ErrorSnackBar extends StatelessWidget {
  const ErrorSnackBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(6),
      backgroundColor: const Color.fromARGB(255, 245, 225, 225),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: ConstantColors.kErrorColor),
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      content: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: ConstantColors.kErrorColor,
            ),
      ),
    );
  }
}
