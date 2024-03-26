import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resultListScrollControllerProvider = Provider<ResultListScrollController>(
  (ref) => ResultListScrollController(ref),
);

class ResultListScrollController {
  ResultListScrollController(this.ref);

  final Ref ref;

  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 240),
        curve: Curves.decelerate,
      );
    });
  }
}
