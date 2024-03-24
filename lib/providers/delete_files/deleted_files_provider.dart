import 'dart:io';

import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteFilesProvider =
    StateNotifierProvider.autoDispose<DeletedFilesNotifier, List<HandledFile>?>(
        (ref) => DeletedFilesNotifier(ref));

class DeletedFilesNotifier extends StateNotifier<List<HandledFile>?> {
  DeletedFilesNotifier(this.ref) : super(null);

  Ref ref;

  List<HandledFile> deleteFiles() {
    ref.read(directoryProvider.notifier).walkFiles(
          ref,
          (file, _) => _deleteFile(file),
        );

    state ??= [];

    return state!;
  }

  void _deleteFile(File file) {
    if (file.hasAccess && file.parent.hasAccess) {
      file.deleteSync();

      state = [
        ...state ?? [],
        HandledFile.create(
          file: file,
          deleted: true,
          resultMessage: ResultType.DELETED,
        ),
      ];
    } else {
      state = [
        ...state ?? [],
        HandledFile.create(
          file: file,
          resultMessage: ResultType.ACCESS_DENIED,
        ),
      ];
    }
  }
}
