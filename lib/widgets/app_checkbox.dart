import 'package:file_handler/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged});

  final String title;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          child: Transform.scale(
            scale: 0.8,
            child: CupertinoCheckbox(
              value: value,
              activeColor: AppColor.ceruleanBlue,
              checkColor: Colors.white,
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: onChanged != null ? Colors.white : Colors.grey,
          ),
        ),
      ],
    );
  }
}
