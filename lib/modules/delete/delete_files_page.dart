import 'package:file_handler/providers/delete_files/deleted_files_provider.dart';
import 'package:file_handler/widgets/available_extensions.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:file_handler/widgets/page_wrapper.dart';
import 'package:file_handler/widgets/result_list/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteFilesPage extends ConsumerWidget {
  const DeleteFilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedFiles = ref.watch(deleteFilesProvider);

    return PageWrapper(
      title: 'Delete Files',
      bodyChildren: deletedFiles == null
          ? const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvailableExtensions(),
                ],
              ),
            )
          : ResultList(resultList: deletedFiles),
      bottomChildren: JobButtonAndSummary(
        buttonTitle: 'Delete files',
        files: deletedFiles,
        onPressed: () => ref.read(deleteFilesProvider.notifier).deleteFiles(),
      ),
    );
  }
}
