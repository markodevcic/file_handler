import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/widgets/job_button.dart';
import 'package:flutter/material.dart';

class JobButtonAndSummary extends StatelessWidget {
  const JobButtonAndSummary(
      {super.key,
      required this.buttonTitle,
      required this.files,
      required this.onPressed});

  final String buttonTitle;
  final List<HandledFile>? files;
  final List<HandledFile> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (files != null)
          Text(
            'Total files: ${files!.length}',
          ),
        const Spacer(),
        JobButton(
          title: buttonTitle,
          handledFiles: files,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
