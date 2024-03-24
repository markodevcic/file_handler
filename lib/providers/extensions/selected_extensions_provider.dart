import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedExtensionsProvider =
    StateNotifierProvider.autoDispose<SelectedExtensionsNotifier, List<String>>(
  (ref) => SelectedExtensionsNotifier(),
);

class SelectedExtensionsNotifier extends StateNotifier<List<String>> {
  SelectedExtensionsNotifier() : super([]);

  void toggleExtension(String extension) {
    if (state.contains(extension)) {
      state = state.where((e) => e != extension).toList();
    } else {
      state = [...state, extension];
    }
  }

  void addAllExtensions(List<String> extensions) {
    state = extensions.toList();
  }

  void removeAllExtensions() {
    state = [];
  }
}
