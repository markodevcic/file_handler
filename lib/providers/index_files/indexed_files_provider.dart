import 'dart:io';

import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:file_handler/providers/index_files/index_symbol_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexedFilesProvider =
    StateNotifierProvider.autoDispose<IndexedFilesNotifier, List<HandledFile>?>(
        (ref) => IndexedFilesNotifier(ref));

class IndexedFilesNotifier extends StateNotifier<List<HandledFile>?> {
  IndexedFilesNotifier(this.ref) : super(null);

  Ref ref;

  List<HandledFile> indexFiles() {
    ref.read(directoryProvider.notifier).walkFiles(ref, _indexFile);

    state ??= [];

    return state!;
  }

  void _indexFile(File file, int index) {
    if (file.hasAccess && file.parent.hasAccess) {
      final String indexSymbol = ref.read(indexSymbolProvider);

      String indexNumber = '${'$index'.padLeft(2, '0')}$indexSymbol';

      file.renameSync(
          '${file.parent.path}${Platform.pathSeparator}$indexNumber${file.nameWithExtension}');

      state = [
        ...state ?? [],
        HandledFile.create(
          file: file,
          newName: indexNumber + file.nameWithExtension,
          resultMessage: ResultType.INDEXED,
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
