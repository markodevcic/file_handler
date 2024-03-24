import 'package:flutter_riverpod/flutter_riverpod.dart';

final renameFileTextProvider =
    Provider.autoDispose<RenameFileTextProvider>((ref) {
  return RenameFileTextProvider();
});

class RenameFileTextProvider {
  String text = '';

  void setText(String value) {
    text = value;
  }
}
