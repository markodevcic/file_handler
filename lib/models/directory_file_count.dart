class DirectoryFileCount {
  final String directory;
  final int fileCount;

  DirectoryFileCount({required this.directory, required this.fileCount});

  DirectoryFileCount.fromJson(Map<String, dynamic> json)
      : directory = json['directory'],
        fileCount = json['fileCount'];

  Map<String, dynamic> toJson() => {
        'directory': directory,
        'fileCount': fileCount,
      };
}
