import 'dart:developer';

import 'package:desktop_window/desktop_window.dart';
import 'package:file_handler/extensions.dart';
import 'package:file_handler/modules/delete/delete_files_page.dart';
import 'package:file_handler/modules/index/index_files/index_files_page.dart';
import 'package:file_handler/modules/index/un_index_files/un_index_files_page.dart';
import 'package:file_handler/modules/rename/add_text/add_text_page.dart';
import 'package:file_handler/modules/rename/remove_text/remove_text_page.dart';
import 'package:file_handler/providers/directory/directory_provider.dart';
import 'package:file_handler/providers/directory/subdirectories_inclusion.dart';
import 'package:file_handler/widgets/app_checkbox.dart';
import 'package:file_handler/widgets/app_list_tile.dart';
import 'package:file_handler/widgets/app_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setWindowSize(const Size(600, 600));
  await DesktopWindow.setMinWindowSize(const Size(600, 600));

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File handler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.blue.withOpacity(0.2),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDirectory = ref.watch(directoryProvider).path;
    final directory = ref.watch(directoryProvider);
    final selectedDirectoryNotifier = ref.read(directoryProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Directory'),
              const Text(
                'Select root directory to start handling files',
                style: TextStyle(height: 2, fontSize: 10, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  AppOutlinedButton(
                    icon: Icons.folder_open,
                    onPressed: () async {
                      await selectedDirectoryNotifier.selectRootDirectory();
                      if (directory.hasAccess == false) {
                        log('Directory has no access');
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      selectedDirectory.isEmpty ? '' : selectedDirectory,
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCheckbox(
                    title: 'Include subdirectories',
                    value: ref.watch(includeSubDirectoriesProvider),
                    onChanged: selectedDirectory.isNotEmpty
                        ? (value) {
                            ref
                                .read(includeSubDirectoriesProvider.notifier)
                                .toggleIncludeSubDirectories();
                            if (ref.read(excludeRootFilesProvider) && !value!) {
                              ref
                                  .read(excludeRootFilesProvider.notifier)
                                  .toggleExcludeRootFiles();
                            }
                          }
                        : null,
                  ),
                  AppCheckbox(
                    title: 'Exclude root files',
                    value: ref.watch(excludeRootFilesProvider),
                    onChanged: selectedDirectory.isNotEmpty &&
                            ref.watch(includeSubDirectoriesProvider)
                        ? (value) {
                            ref
                                .read(excludeRootFilesProvider.notifier)
                                .toggleExcludeRootFiles();
                          }
                        : null,
                  ),
                  const SizedBox(height: 16),
                  AppListTile(
                    title: 'Index Files',
                    subtitle:
                        'Create ordered file list by adding numbers at the beginning of file names',
                    onTap: selectedDirectory.isNotEmpty
                        ? () {
                            context.push(const IndexFilesPage());
                          }
                        : null,
                  ),
                  AppListTile(
                    title: 'Un-Index Files',
                    subtitle:
                        'Remove ordered numbers from the beginning of file names',
                    onTap: selectedDirectory.isNotEmpty
                        ? () {
                            context.push(const UnIndexFilesPage());
                          }
                        : null,
                  ),
                  AppListTile(
                    title: 'Remove text',
                    subtitle: 'Remove specific text from file names',
                    onTap: selectedDirectory.isNotEmpty
                        ? () {
                            context.push(const RemoveTextPage());
                          }
                        : null,
                  ),
                  AppListTile(
                    title: 'Add text',
                    subtitle:
                        'Add text at the beginning or at the end of file names',
                    onTap: selectedDirectory.isNotEmpty
                        ? () {
                            context.push(const AddTextPage());
                          }
                        : null,
                  ),
                  AppListTile(
                    title: 'Delete files',
                    subtitle: 'Delete files with specified filetypes',
                    onTap: selectedDirectory.isNotEmpty
                        ? () {
                            context.push(const DeleteFilesPage());
                          }
                        : null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
