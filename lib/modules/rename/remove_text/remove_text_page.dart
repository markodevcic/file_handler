import 'package:file_handler/modules/rename/widgets/rename_text.dart';
import 'package:file_handler/providers/rename_files/rename_file_provider.dart';
import 'package:file_handler/widgets/available_extensions.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:file_handler/widgets/page_wrapper.dart';
import 'package:file_handler/widgets/result_list/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveTextPage extends ConsumerWidget {
  const RemoveTextPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renamedFiles = ref.watch(renameFileProvider);

    return PageWrapper(
      title: 'Remove text from file names',
      bodyChildren: renamedFiles == null
          ? const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvailableExtensions(),
                  RenameText(
                    title: 'Remove text',
                    subtitle: 'removed',
                  ),
                ],
              ),
            )
          : ResultList(resultList: renamedFiles),
      bottomChildren: JobButtonAndSummary(
        buttonTitle: 'Remove text',
        files: renamedFiles,
        onPressed: () => ref.read(renameFileProvider.notifier).removeText(),
      ),
    );
  }
}
