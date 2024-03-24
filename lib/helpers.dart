import 'dart:io';

Set<String> getAvailableExtensions(String selectedDirectory) {
  Set<String> fileExtensions = {};

  Directory(selectedDirectory)
      .listSync(recursive: true)
      .forEach((FileSystemEntity entity) {
    if (entity is File) {
      String fileName = entity.path.split(Platform.pathSeparator).last;
      if (!fileName.startsWith('.')) {
        String fileExtension = fileName.split('.').last;
        fileExtensions.add(fileExtension);
      }
    }
  });

  return fileExtensions;
}
