import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Position { BEGINNING, BEGINNING_PLUS_SPACE, END, SPACE_PLUS_END }

final addTextPositionProvider =
    StateNotifierProvider.autoDispose<AddTextPositionProvider, Position>((ref) {
  return AddTextPositionProvider();
});

class AddTextPositionProvider extends StateNotifier<Position> {
  AddTextPositionProvider() : super(Position.BEGINNING_PLUS_SPACE);

  void setAddTextPosition(Position position) {
    state = position;
  }
}
