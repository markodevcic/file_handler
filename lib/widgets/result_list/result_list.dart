import 'dart:io';

import 'package:file_handler/constants.dart';
import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:file_handler/widgets/result_list/result_list_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

class ResultList extends ConsumerWidget {
  const ResultList({super.key, required this.resultList});

  final List<HandledFile> resultList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootDirectory = ref.read(directoryProvider);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      controller: ref.watch(resultListScrollControllerProvider),
      itemCount: resultList.map((e) => e.directory).toSet().length,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) {
        final dirPathList = resultList.map((e) => e.directory).toSet();
        final dirList = dirPathList.map((path) => Directory(path)).toList();

        if (resultList.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.folder_outlined,
                    color: AppColor.tangerineOrange,
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      path.relative(dirList.elementAt(index).path,
                          from: rootDirectory.parent.path),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  RichText(
                    text: TextSpan(
                      text: 'Accessible ',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      children: [
                        TextSpan(
                          text: dirList.elementAt(index).hasAccess.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: dirList.elementAt(index).hasAccess
                                ? AppColor.mintGreen
                                : AppColor.lightScarletRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Original name',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      if (resultList
                              .firstWhere((entity) =>
                                  entity.directory ==
                                  dirList.elementAt(index).path)
                              .newName !=
                          null)
                        const Text(
                          'New name',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      const Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ...resultList
                      .where((entity) =>
                          entity.directory == dirList.elementAt(index).path)
                      .map(
                    (file) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  file.originalName,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: file.result ==
                                                  ResultType.ACCESS_DENIED ||
                                              file.result ==
                                                  ResultType.EMPTY_FILE_NAME
                                          ? AppColor.lightScarletRed
                                          : AppColor.mintGreen),
                                ),
                              ),
                              const SizedBox(width: 16),
                              if (file.newName != null)
                                Expanded(
                                  child: Text(
                                    file.newName!,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColor.mintGreen),
                                  ),
                                ),
                              const SizedBox(width: 16),
                              Text(
                                file.result.message,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: file.result ==
                                                ResultType.ACCESS_DENIED ||
                                            file.result ==
                                                ResultType.EMPTY_FILE_NAME
                                        ? AppColor.lightScarletRed
                                        : AppColor.mintGreen),
                              ),
                            ],
                          ),
                          const Divider(height: 4),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container(
            color: Colors.red,
            child: const Center(
              child: Text(
                'No files found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        }
      },
    );
  }
}
