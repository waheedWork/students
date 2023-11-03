import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget showLongString(String string) {
  if (string.length >= 20) {
    return SizedBox(
      width: Get.width / 2,
      child: Text(
        string.replaceRange(20, string.length, '...'),
      ),
    );
  } else {
    return SizedBox(
      width: Get.width / 2,
      child: Text(
        string,
      ),
    );
  }
}
Widget showDrawerString(String string) {
  if (string.length >= 10) {
    return SizedBox(
      width: Get.width /4,
      child: Text(
        string.replaceRange(10, string.length, '...'),
      ),
    );
  } else {
    return SizedBox(
      width: Get.width / 4,
      child: Text(
        string,
      ),
    );
  }
}
Widget showAppBarString(String string) {
  if (string.length >= 14) {
    return SizedBox(
      width: Get.width /3,
      child: Text(
        string.replaceRange(14, string.length, '...'),
      ),
    );
  } else {
    return SizedBox(
      width: Get.width / 3,
      child: Text(
        string,
      ),
    );
  }
}
