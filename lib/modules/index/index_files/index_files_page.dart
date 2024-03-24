import 'package:file_handler/modules/index/index_files/widgets/indexing_symbol.dart';
import 'package:file_handler/providers/index_files/indexed_files_provider.dart';
import 'package:file_handler/widgets/available_extensions.dart';
import 'package:file_handler/widgets/job_button_and_summary.dart';
import 'package:file_handler/widgets/page_wrapper.dart';
import 'package:file_handler/widgets/result_list/result_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndexFilesPage extends ConsumerWidget {
  const IndexFilesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexedFiles = ref.watch(indexedFilesProvider);

    return PageWrapper(
      title: 'Index Files',
      bodyChildren: indexedFiles == null
          ? const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvailableExtensions(),
                  IndexingSymbol(),
                ],
              ),
            )
          : ResultList(resultList: indexedFiles),
      bottomChildren: JobButtonAndSummary(
        buttonTitle: 'Index files',
        files: indexedFiles,
        onPressed: () => ref.read(indexedFilesProvider.notifier).indexFiles(),
      ),
    );
  }
}
