import 'dart:io';

import 'package:file_handler/constants.dart';
import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/models/handled_file.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:file_handler/providers/rename_files/add_text_position_provider.dart';
import 'package:file_handler/providers/rename_files/rename_file_text_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final renameFileProvider =
    StateNotifierProvider.autoDispose<RenameFileNotifier, List<HandledFile>?>(
        (ref) {
  return RenameFileNotifier(ref);
});

class RenameFileNotifier extends StateNotifier<List<HandledFile>?> {
  RenameFileNotifier(this.ref) : super(null);

  Ref ref;

  List<HandledFile> removeText() {
    ref.read(directoryProvider.notifier).walkFiles(
          ref,
          (file, _) => _removeText(file),
        );

    state ??= [];

    return state!;
  }

  void _removeText(File file) {
    if (file.hasAccess && file.parent.hasAccess) {
      final String unwantedText = ref.read(renameFileTextProvider).text;

      if (unwantedText.isNotEmpty && file.name.contains(unwantedText)) {
        String renamedFileName =
            file.name.replaceFirst(unwantedText, '').trim();

        if (renamedFileName.isEmpty) {
          state = [
            ...state ?? [],
            HandledFile.create(
              file: file,
              resultMessage: ResultType.EMPTY_FILE_NAME,
            ),
          ];
        } else {
          file.rename(
              '${file.parent.path}$slash$renamedFileName.${file.extension}');

          state = [
            ...state ?? [],
            HandledFile.create(
              file: file,
              newName: '$renamedFileName.${file.extension}',
              resultMessage: ResultType.RENAMED,
            ),
          ];
        }
      }
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

  List<HandledFile> addText() {
    ref.read(directoryProvider.notifier).walkFiles(
          ref,
          (file, _) => _addText(file),
        );

    state ??= [];

    return state!;
  }

  void _addText(File file) {
    if (file.hasAccess && file.parent.hasAccess) {
      final String addText = ref.read(renameFileTextProvider).text;
      final Position textPosition = ref.read(addTextPositionProvider);

      String renamedFileName = '';

      switch (textPosition) {
        case Position.BEGINNING:
          renamedFileName = '${addText.trim()}${file.name}';
          break;
        case Position.BEGINNING_PLUS_SPACE:
          renamedFileName = '${addText.trim()} ${file.name.trimLeft()}';
          break;
        case Position.END:
          renamedFileName = '${file.name}${addText.trim()}';
          break;
        case Position.SPACE_PLUS_END:
          renamedFileName = '${file.name.trimRight()} ${addText.trim()}';
          break;
      }

      if (renamedFileName.isEmpty) {
        state = [
          ...state ?? [],
          HandledFile.create(
            file: file,
            resultMessage: ResultType.EMPTY_FILE_NAME,
          ),
        ];
      } else {
        file.rename(
            '${file.parent.path}$slash$renamedFileName.${file.extension}');

        state = [
          ...state ?? [],
          HandledFile.create(
            file: file,
            newName: '$renamedFileName.${file.extension}',
            resultMessage: ResultType.RENAMED,
          ),
        ];
      }
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
