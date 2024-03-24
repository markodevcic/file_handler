import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexSymbolProvider =
    StateNotifierProvider.autoDispose<IndexSymbolNotifier, String>(
  (ref) => IndexSymbolNotifier(),
);

class IndexSymbolNotifier extends StateNotifier<String> {
  IndexSymbolNotifier() : super(' - ');

  void set(String symbol) {
    state = symbol;
  }
}
