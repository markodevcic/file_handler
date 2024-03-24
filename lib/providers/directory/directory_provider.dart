import 'dart:io';

import 'package:file_handler/constants.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/providers/directory/subdirectories_inclusion.dart';
import 'package:file_handler/providers/extensions/selected_extensions_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final directoryProvider =
    StateNotifierProvider<DirectoryProvider, Directory>((ref) {
  return DirectoryProvider(ref);
});

class DirectoryProvider extends StateNotifier<Directory> {
  DirectoryProvider(this.ref) : super(Directory(''));

  Ref ref;

  Future<void> selectRootDirectory() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
      state = Directory(result);
    }
  }

  void walkFiles(Ref ref, Function(File, int) callback) {
    final String rootDirectory = ref.read(directoryProvider).path;
    final bool includeSubDirectories = ref.read(includeSubDirectoriesProvider);
    final bool excludeRootFiles = ref.read(excludeRootFilesProvider);
    final List<String> extensions = ref.read(selectedExtensionsProvider);

    List<String> directoryPaths = [];
    // List<Map<String, dynamic>> directoryFileCount = [
    //   {'directory': rootDirectory, 'fileCount': 0}
    // ];

    for (var entity in Directory(rootDirectory)
        .listSync(recursive: includeSubDirectories)) {
      if (entity.parent.path == rootDirectory && excludeRootFiles) {
        continue;
      }

      // if (entity is Directory) {
      //   log('directory path: ${entity.path}');
      //   directoryFileCount.add({'directory': entity.path, 'fileCount': 0});
      // }

      if (entity is File) {
        if (!excludePrefixes
                .any((prefix) => entity.nameWithExtension.startsWith(prefix)) &&
            extensions.contains(entity.extension)) {
          directoryPaths.add(entity.parent.path);
          // directoryFileCount
          //     .where((element) => element['directory'] == entity.parent.path)
          //     .first['fileCount']++;

          int index = directoryPaths
              .where((element) => element == entity.parent.path)
              .length;
          // int index = directoryFileCount
          //     .where((element) => element['directory'] == entity.parent.path)
          //     .first['fileCount'];
          callback(entity, index);
        }
      }
    }
  }

  Future<void> walkDirectories(Ref ref, Function(File, int) callback) async {
    final String currentDirectory = ref.read(directoryProvider).path;
    final bool includeSubDirectories = ref.read(includeSubDirectoriesProvider);
    final bool excludeRootFiles = ref.read(excludeRootFilesProvider);
    final List<String> extensions = ref.read(selectedExtensionsProvider);

    int rootFileIndex = 0;

    for (var entity in Directory(currentDirectory).listSync()) {
      if (includeSubDirectories) {
        if (entity is Directory) {
          // if (entity.hasAccess) {
          //   continue;
          // }

          List<File> files = _filterFiles(entity, extensions);

          for (var file in files) {
            callback(file, files.indexOf(file));
          }
        }
      }

      if (!excludeRootFiles) {
        if (entity is File) {
          if (!excludePrefixes
                  .any((prefix) => entity.name.startsWith(prefix)) &&
              extensions.contains(entity.extension)) {
            callback(entity, rootFileIndex++);
          }
        }
      }
    }
  }

  List<File> _filterFiles(Directory directory, List<String> extensions) {
    List<File> allFiles = directory.files;

    List<File> files = allFiles.where((file) {
      return extensions.contains(file.extension) &&
          !excludePrefixes.any((prefix) => file.name.startsWith(prefix));
    }).toList();

    return files;
  }
}
