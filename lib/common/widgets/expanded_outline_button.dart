import 'package:flutter/material.dart';

class ExpandedOutlineButton extends StatelessWidget {
  const ExpandedOutlineButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.buttonStyle,
    this.textStyle,
  });

  final String title;
  final VoidCallback onTap;
  final Widget? icon;
  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return (icon == null)
        ? SizedBox(
            width: double.infinity,
            child: OutlinedButton(
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
            child: OutlinedButton.icon(
              style: buttonStyle,
              onPressed: onTap,
              icon: icon!,
              label: Text(
                title,
                style: textStyle,
              ),
            ),
          );
  }
}
