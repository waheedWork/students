import 'dart:async';

import 'package:get/get.dart';

class LoadController extends GetxController {
  int late = 0;

  void setLate(int i) {
    late = 0;
    update();
  }

  timer() {
    Timer(const Duration(seconds: 8), () {
      late++;
      update();
      print('========$late=================');
    });
  }

  @override
  void onInit() {
    if (late == 0) {
      timer();
    }
    super.onInit();
  }
}
