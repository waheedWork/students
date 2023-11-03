class AppFunctions {
  static String getDate(String dateTime) {
    return dateTime.replaceRange(dateTime.length-9, dateTime.length, '');
  }
}
