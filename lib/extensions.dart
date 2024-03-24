import 'dart:io';

import 'package:flutter/material.dart';

extension FileSystemEntityExtension on FileSystemEntity {
  bool get hasAccess {
    final entityStat = statSync();

    final isReadable = entityStat.modeString().contains('r');
    final isWritable = entityStat.modeString().contains('w');

    return isReadable && isWritable;
  }
}

extension FileExtension on File {
  bool get hasAccess {
    final entityStat = statSync();

    final isReadable = entityStat.modeString().contains('r');
    final isWritable = entityStat.modeString().contains('w');

    return isReadable && isWritable;
  }

  String get name {
    int lastDotIndex = nameWithExtension.lastIndexOf('.');
    return lastDotIndex != -1
        ? nameWithExtension.substring(0, lastDotIndex)
        : nameWithExtension;
  }

  String get extension =>
      path.split(Platform.pathSeparator).last.split('.').last;
  String get nameWithExtension => path.split(Platform.pathSeparator).last;
}

extension DirectoryExtension on Directory {
  bool get hasAccess {
    final entityStat = statSync();

    final isReadable = entityStat.modeString().contains('r');
    final isWritable = entityStat.modeString().contains('w');

    return isReadable && isWritable;
  }

  List<File> get files => listSync().whereType<File>().toList();
}

extension NavigationExtension on BuildContext {
  void push(Widget widget, {Duration? transitionDuration}) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void pushReplacement(Widget widget, {Duration? transitionDuration}) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void pop() {
    Navigator.pop(this);
  }

  bool canPop() {
    return Navigator.canPop(this);
  }

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get color => Theme.of(this).colorScheme;
}
