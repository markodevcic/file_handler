import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/extensions/selected_extensions_provider.dart';
import 'package:file_handler/widgets/app_outlined_button.dart';
import 'package:file_handler/widgets/result_list/result_list_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobButton extends ConsumerWidget {
  const JobButton({
    super.key,
    required this.title,
    required this.handledFiles,
    required this.onPressed,
  });

  final String title;
  final List<HandledFile>? handledFiles;
  final List<HandledFile> Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedExtensions = ref.watch(selectedExtensionsProvider);

    return handledFiles != null
        ? AppOutlinedButton(
            onPressed: () {
              context.pop();
            },
            title: 'Done',
          )
        : AppOutlinedButton(
            onPressed: selectedExtensions.isNotEmpty
                ? () {
                    final files = onPressed();
                    if (files.isNotEmpty) {
                      ref
                          .read(resultListScrollControllerProvider)
                          .scrollToBottom();
                    }
                  }
                : null,
            title: title,
          );
  }
}
