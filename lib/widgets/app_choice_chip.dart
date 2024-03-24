import 'package:file_handler/constants.dart';
import 'package:flutter/material.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip(
      {super.key,
      required this.title,
      required this.selected,
      required this.onSelected,
      this.showCheckmark = true});

  final String title;
  final bool selected;
  final void Function(bool)? onSelected;
  final bool showCheckmark;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
      showCheckmark: showCheckmark,
      selectedColor: AppColor.ceruleanBlue,
      selected: selected,
      onSelected: onSelected,
    );
  }
}
