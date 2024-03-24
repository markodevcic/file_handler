import 'dart:io';

import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final unIndexedFilesProvider = StateNotifierProvider.autoDispose<
    UnIndexedFilesNotifier,
    List<HandledFile>?>((ref) => UnIndexedFilesNotifier(ref));

class UnIndexedFilesNotifier extends StateNotifier<List<HandledFile>?> {
  UnIndexedFilesNotifier(this.ref) : super(null);

  Ref ref;

  List<HandledFile> unIndexFiles() {
    ref.read(directoryProvider.notifier).walkFiles(
          ref,
          (file, _) => _unIndexFile(file),
        );

    state ??= [];

    return state!;
  }

  void _unIndexFile(File file) {
    RegExp indexPrefix = RegExp(r'^\d+(\s*[-._)]?\s*)[-._)]?\s*');

    if (indexPrefix.hasMatch(file.name)) {
      if (file.hasAccess && file.parent.hasAccess) {
        String unIndexedFileName =
            file.nameWithExtension.replaceFirst(indexPrefix, '');

        file.renameSync(
            '${file.parent.path}${Platform.pathSeparator}$unIndexedFileName');

        state = [
          ...state ?? [],
          HandledFile.create(
            file: file,
            newName: unIndexedFileName,
            resultMessage: ResultType.UN_INDEXED,
          ),
        ];
      } else {
        state = [
          ...state ?? [],
          HandledFile.create(
            file: file,
            resultMessage: ResultType.ACCESS_DENIED,
          )
        ];
      }
    }
  }
}
