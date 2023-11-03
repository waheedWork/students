import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/login.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/services/services.dart';

import '../controller/auth_controllers/student/login.dart';

class MiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  final MyServices _myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    print('======MiddleWareMiddleWareMiddleWare================');
    if (_myServices.sharedPreferences.getString('step') == '1') {
      // Get.toNamed(AppRoute.loginTeacher);
      TeacherLoginController teacherLoginController =
          Get.put(TeacherLoginController(), permanent: true);
      teacherLoginController.loginTeacherWithData();
    } else if (_myServices.sharedPreferences.getString('step') == '2') {
      // Get.toNamed(AppRoute.loginStudent);
      StudentLoginController studentLoginController =
          Get.put(StudentLoginController());
      studentLoginController.loginStudentWithData();
    } else {
      return RouteSettings(name: AppRoute.userTypePage);
    }
  }
}
