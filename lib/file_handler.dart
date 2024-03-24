// import 'dart:io';

// void main() {
//   clear();

//   print('Choose an option:');

//   const List<String> features = [
//     '1. Index files (add numbers at the beginning of each file of filetype '
//         'you choose)',
//     '2. Remove specific text from filename',
//     '3. Add text at the beginning of the filename',
//     '4. Delete files with specific filetypes of your choice'
//   ];

//   features.map((feature) => print(feature)).toList();

//   stdout.write('--> ');

//   final int option = int.parse(stdin.readLineSync() ?? '');

//   print('\n');

//   switch (option) {
//     case 1:
//       return indexFiles();
//     case 2:
//       return removeString();
//     case 3:
//       return addStringAtStart();
//     case 4:
//       return deleteFiles();
//     default:
//       print('You didn\'t choose any of the given options.');
//   }
// }

// void clear() => Process.run(Platform.isWindows ? 'cls' : 'clear', []);

// String slash = Platform.pathSeparator;
// List<String> excludePrefixes = ['__', '.'];

// void removeString() {
//   int renamedFiles = 0;

//   print('Choose file extension you want to remove string fromn');
//   getAvailableExtensions().map((extension) => print(' - $extension')).toList();
//   String fileType = stdin.readLineSync() ?? '';

//   stdout.write(
//       'Type or paste piece of text you want to remove from file name\n--> ');
//   String unwantedString = stdin.readLineSync() ?? '';

//   Directory fullDirectory = Directory.current;
//   fullDirectory.list(recursive: true).listen((FileSystemEntity entity) {
//     if (entity is File) {
//       String fileName = entity.path.split(slash).last;
//       String dirName = entity.parent.path.split(slash).last;
//       if (!excludePrefixes.any((prefix) => fileName.startsWith(prefix))) {
//         if (unwantedString.isNotEmpty &&
//             fileName.contains(unwantedString) &&
//             fileName.endsWith('${fileType}')) {
//           String renamedFileName = fileName.replaceAll(unwantedString, '');
//           if (renamedFileName.split('.').first.isEmpty) {
//             print(
//                 '--> File "$dirName/$fileName"\n\tis not renamed\n\tbecause the result is an empty string\n');
//           } else {
//             entity.rename(entity.parent.path + slash + renamedFileName);
//             print(
//                 '--> File "$dirName/$fileName"\n\tis renamed to\n\t"$renamedFileName"\n');
//             renamedFiles++;
//           }
//         }
//       }
//     }
//   }).onDone(() {
//     print('Total renamed items: $renamedFiles');
//   });
// }

// void addStringAtStart() {
//   int renamedFiles = 0;

//   stdout.write('Choose file extension you want to add string to\n'
//       '(example: mp3, jpg, txt, pdf, html... )\n--> ');
//   String fileType = stdin.readLineSync() ?? '';

//   stdout.write(
//       'Type or paste piece of text you want to add at the filename beginning\n--> ');
//   String addString = stdin.readLineSync() ?? '';

//   Directory.current.list(recursive: true).listen((FileSystemEntity entity) {
//     if (entity is File) {
//       String fileName = entity.path.split(Platform.pathSeparator).last;
//       String dirName = entity.parent.path.split(Platform.pathSeparator).last;
//       if (!excludePrefixes.any((prefix) => fileName.startsWith(prefix))) {
//         if (fileName.endsWith('.$fileType')) {
//           String renamedFileName = '$addString$fileName';
//           entity.rename(
//               '${entity.parent.path}${Platform.pathSeparator}$renamedFileName');
//           print(
//               '--> File "$dirName/$fileName"\n\tis renamed to\n\t"$renamedFileName"\n');
//           renamedFiles++;
//         }
//       }
//     }
//   }).onDone(() {
//     print('Total renamed items: $renamedFiles');
//   });
// }

// void indexFiles() {
//   int renamedFiles = 0;

//   stdout.write('Type the exact file extension you want to index\n'
//       '(example: mp3, jpg, txt, pdf, html... )\n--> ');
//   String fileType = stdin.readLineSync() ?? '';

//   int rootFileIndex = 1;

//   for (var entity in Directory.current.listSync()) {
//     if (entity is Directory) {
//       List<File> files = entity.listSync().whereType<File>().toList();

//       for (var i = 0; i < files.length; i++) {
//         File file = files[i];
//         String fileName = file.path.split(Platform.pathSeparator).last;
//         String dirName = entity.path.split(Platform.pathSeparator).last;
//         if (!excludePrefixes.any((prefix) => fileName.startsWith(prefix))) {
//           if (fileName.endsWith('.$fileType')) {
//             String indexNumber = '${i}'.padLeft(2, '0') + ' - ';
//             file.renameSync(
//                 '${file.parent.path}${Platform.pathSeparator}$indexNumber$fileName');
//             print(
//                 '--> File "$dirName/$fileName"\n\tis indexed as\n\t"$indexNumber$fileName"\n');
//             renamedFiles++;
//           }
//         }
//       }
//     }

//     if (entity is File) {
//       String fileName = entity.path.split(Platform.pathSeparator).last;
//       if (!excludePrefixes.any((prefix) => fileName.startsWith(prefix))) {
//         if (fileName.endsWith('.$fileType')) {
//           String indexNumber = '${rootFileIndex}'.padLeft(2, '0') + ' - ';
//           entity.renameSync(
//               '${entity.parent.path}${Platform.pathSeparator}$indexNumber$fileName');
//           print(
//               '--> File "$fileName"\n\tis indexed as\n\t"$indexNumber$fileName"\n');
//           renamedFiles++;
//           rootFileIndex++;
//         }
//       }
//     }
//   }

//   print('Total indexed files: $renamedFiles');
// }

// void deleteFiles() {
//   int deletedFiles = 0;

//   stdout.write('Type the exact file extension for files you want to delete\n'
//       '(example: mp3, jpg, txt, pdf, html...)\n--> ');
//   String fileType = stdin.readLineSync() ?? '';

//   Directory.current.list(recursive: true).listen((FileSystemEntity entity) {
//     if (entity is File) {
//       String fileName = entity.path.split(Platform.pathSeparator).last;
//       if (fileName.endsWith('.$fileType')) {
//         entity.deleteSync();
//         print('--> Deleted file "$fileName"\n');
//         deletedFiles++;
//       }
//     }
//   }).onDone(() {
//     print('Total deleted items: $deletedFiles');
//   });
// }

// Set<String> getAvailableExtensions() {
//   Set<String> fileExtensions = {};

//   Directory.current
//       .listSync(recursive: true)
//       .forEach((FileSystemEntity entity) {
//     if (entity is File) {
//       String fileName = entity.path.split(Platform.pathSeparator).last;
//       String fileExtension = fileName.split('.').last;
//       fileExtensions.add(fileExtension);
//     }
//   });

//   return fileExtensions;
// }
