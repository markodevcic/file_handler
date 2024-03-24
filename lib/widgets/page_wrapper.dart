import 'package:file_handler/extensions.dart';
import 'package:file_handler/widgets/app_outlined_button.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    super.key,
    required this.title,
    required this.bodyChildren,
    required this.bottomChildren,
  });

  final String title;
  final Widget bodyChildren;
  final JobButtonAndSummary bottomChildren;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AppOutlinedButton.back(
                  onPressed: () => context.pop(),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: bodyChildren,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: bottomChildren,
          ),
        ],
      ),
    );
  }
}
