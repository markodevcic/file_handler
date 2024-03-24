import 'package:file_handler/providers/index_files/un_indexed_files_provider.dart';
import 'package:file_handler/widgets/available_extensions.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:file_handler/widgets/page_wrapper.dart';
import 'package:file_handler/widgets/result_list/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnIndexFilesPage extends ConsumerWidget {
  const UnIndexFilesPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unIndexedFiles = ref.watch(unIndexedFilesProvider);

    return PageWrapper(
      title: 'Un-Index files',
      bodyChildren: unIndexedFiles == null
          ? const AvailableExtensions()
          : ResultList(resultList: unIndexedFiles),
      bottomChildren: JobButtonAndSummary(
        buttonTitle: 'Un-Index files',
        files: unIndexedFiles,
        onPressed: () =>
            ref.read(unIndexedFilesProvider.notifier).unIndexFiles(),
      ),
    );
  }
}
