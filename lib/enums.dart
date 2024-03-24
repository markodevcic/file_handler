enum ResultType {
  INDEXED('Indexed'),
  UN_INDEXED('Un-indexed'),
  DELETED('Deleted'),
  RENAMED('Renamed'),
  ACCESS_DENIED('Access denied'),
  EMPTY_FILE_NAME('Not renamed because it would be empty');

  final String message;

  const ResultType(this.message);
}
