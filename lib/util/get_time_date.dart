// we want to break the term below into 'date' and 'time':
// "created": "2023-09-24 11:17:20.334Z"

String getTime(String creationTimeInPocketBase) {
  return creationTimeInPocketBase.substring(11, 16);
}

String getDate(String creationTimeInPocketBase) {
  String year = creationTimeInPocketBase.substring(0, 4);
  String month = creationTimeInPocketBase.substring(5, 7);
  String day = creationTimeInPocketBase.substring(8, 10);
  return '$year/$month/$day';
}
