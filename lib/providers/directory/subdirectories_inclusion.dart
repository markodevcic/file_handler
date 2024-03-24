import 'package:flutter_riverpod/flutter_riverpod.dart';

final includeSubDirectoriesProvider =
    StateNotifierProvider<IncludeSubDirectoriesProvider, bool>((ref) {
  return IncludeSubDirectoriesProvider();
});

class IncludeSubDirectoriesProvider extends StateNotifier<bool> {
  IncludeSubDirectoriesProvider() : super(true);

  void toggleIncludeSubDirectories() {
    state = !state;
  }
}

final excludeRootFilesProvider =
    StateNotifierProvider<ExcludeRootFilesProvider, bool>((ref) {
  return ExcludeRootFilesProvider();
});

class ExcludeRootFilesProvider extends StateNotifier<bool> {
  ExcludeRootFilesProvider() : super(false);

  void toggleExcludeRootFiles() {
    state = !state;
  }
}
