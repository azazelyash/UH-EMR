import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  const ExpandedElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonStyle,
    this.icon,
    this.textStyle,
  });

  final String title;
  final VoidCallback onTap;
  final ButtonStyle? buttonStyle;
  final Widget? icon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return (icon == null)
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: onTap,
              child: Text(
                title,
                style: textStyle,
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: buttonStyle,
              onPressed: onTap,
              label: Text(
                title,
                style: textStyle,
              ),
              icon: icon!,
            ),
          );
  }
}
