# File Handler App

The File Handler App is a Flutter application designed to simplify file management tasks on both macOS and Windows operating systems. With this app, users can easily navigate through directories, perform various actions on files, and streamline their file management workflow.

## Features

**Directory Selection**
Upon launching the app, users can select a directory which then becomes the root directory for handling files. This directory serves as the focal point for all file management operations.

**File Handling Options**
Selective File Handling
Users can choose the scope of file handling:

- Root Files Only: Perform actions exclusively on files within the selected root directory.
- Root Files and Subdirectories: Extend actions to include files within subdirectories of the root directory.
- Subdirectories Only (Excluding Root Files): Perform actions exclusively on files within subdirectories, excluding files in the selected root directory.

**File Type Selection**
For each file handling feature, users can select specific file types from all folders and subfolders within the chosen scope. This ensures precise control over file manipulation.

### Available Features

1. **Index File Names:** Add an index to the beginning of file names for organizational purposes. Indexing starts anew for each folder.
2. **Un-index File Names:** Remove numbered indexes from file names added by the app or those files that already have some sort of numbered index in it
3. **Remove Text from File Names:** Eliminate specific text strings from file names, useful for cleaning up naming conventions.
4. **Add Text to File Names:** Append custom text to file names, either at the beginning or the end, to enhance file identification.
5. **Delete Files:** Permanently delete selected files from the file system, restricted to the chosen file types and scope.