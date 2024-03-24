import 'dart:io';

import 'package:file_handler/enums.dart';
import 'package:file_handler/extensions.dart';

class HandledFile {
  String directory;
  String originalName;
  String? newName;
  ResultType result;
  bool deleted;

  HandledFile({
    required this.directory,
    required this.originalName,
    this.newName,
    required this.result,
    this.deleted = false,
  });

  factory HandledFile.create(
      {required File file,
      String? newName,
      required ResultType resultMessage,
      bool deleted = false}) {
    return HandledFile(
      directory: file.parent.path,
      originalName: file.nameWithExtension,
      newName: newName,
      result: resultMessage,
      deleted: deleted,
    );
  }
}
