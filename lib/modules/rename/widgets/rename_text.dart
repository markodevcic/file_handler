import 'package:file_handler/providers/rename_files/rename_file_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RenameText extends ConsumerWidget {
  const RenameText({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            'The text that should be $subtitle',
            style: const TextStyle(height: 2, fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) =>
                ref.watch(renameFileTextProvider).setText(value),
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
