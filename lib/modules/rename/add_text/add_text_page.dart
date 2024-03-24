import 'package:file_handler/modules/rename/add_text/widget/add_text_position.dart';
import 'package:file_handler/modules/rename/widgets/rename_text.dart';
import 'package:file_handler/providers/rename_files/rename_file_provider.dart';
import 'package:file_handler/widgets/available_extensions.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:file_handler/widgets/page_wrapper.dart';
import 'package:file_handler/widgets/result_list/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTextPage extends ConsumerWidget {
  const AddTextPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renamedFiles = ref.watch(renameFileProvider);

    return PageWrapper(
      title: 'Add text to file names',
      bodyChildren: renamedFiles == null
          ? const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvailableExtensions(),
                  AddTextPosition(),
                  RenameText(
                    title: 'Add text',
                    subtitle: 'added',
                  ),
                ],
              ),
            )
          : ResultList(resultList: renamedFiles),
      bottomChildren: JobButtonAndSummary(
        buttonTitle: 'Add text',
        files: renamedFiles,
        onPressed: () => ref.read(renameFileProvider.notifier).addText(),
      ),
    );
  }
}
