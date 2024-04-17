import '../../utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget(
      {super.key,
      required this.items,
      required this.value,
      this.borderSide,
      this.fillColor,
      this.iconColor,
      this.textColor,
      this.decoration,
      this.onChanged});

  final List<String> items;
  final String value;
  final BorderSide? borderSide;
  final Color? fillColor;
  final Color? iconColor;
  final Color? textColor;
  final InputDecoration? decoration;
  final void Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: decoration ??
          InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide ?? BorderSide.none,
              borderRadius: BorderRadius.circular(6),
            ),
            filled: true,
            fillColor: fillColor,
          ),
      dropdownColor: ConstantColors.kWhiteColor,
      value: value,
      onChanged: onChanged,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: iconColor,
        size: 18,
      ),
      selectedItemBuilder: (BuildContext context) => items
          .map<Widget>(
            (item) => Text(
              value,
              style: Theme.of(context).textTheme.titleSmall!,
            ),
          )
          .toList(),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleSmall!,
          ),
        );
      }).toList(),
    );
  }
}
