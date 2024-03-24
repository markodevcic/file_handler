import 'dart:io';

import 'package:file_handler/constants.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:file_handler/providers/directory/subdirectories_inclusion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availableExtensionsProvider = StateNotifierProvider.autoDispose<
    AvailableExtensionsNotifier, List<String>>(
  (ref) => AvailableExtensionsNotifier(ref),
);

class AvailableExtensionsNotifier extends StateNotifier<List<String>> {
  AvailableExtensionsNotifier(this.ref) : super([]) {
    getAvailableExtensions();
  }

  Ref ref;

  void getAvailableExtensions() {
    final String rootDirectory = ref.read(directoryProvider).path;
    final bool includeSubDirectories = ref.read(includeSubDirectoriesProvider);
    final bool excludeRootFiles = ref.read(excludeRootFilesProvider);

    Set<String> fileExtensions = {};

    for (var entity in Directory(rootDirectory)
        .listSync(recursive: includeSubDirectories)) {
      if (entity.parent.path == rootDirectory && excludeRootFiles) {
        continue;
      }

      if (entity is File) {
        if (!excludePrefixes
            .any((prefix) => entity.nameWithExtension.startsWith(prefix))) {
          fileExtensions.add(entity.extension);
        }
      }
    }

    state = fileExtensions.toList();
  }
}
