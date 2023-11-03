import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/auth/teacher/login.dart';

class TeacherLoginController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  TeacherModel teacherModel = TeacherModel();

  changeShow() {
    showText = !showText;
    update();
  }

  loginTeacher(bool hasData) async {
    if (hasData || formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.loginData(
        name: name.text,
        password: password.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          teacherModel = TeacherModel.fromJson(response['data']);
          teacherModel.teacherPassword = password.text;
          String jsonString = jsonEncode(teacherModel.toJson());
          await myServices.sharedPreferences
              .setString('teacherModel', jsonString);
          myServices.sharedPreferences.setString('step', '1');
          update();
          Get.offAllNamed(AppRoute.teacherDashboard);
        } else {
          Get.snackbar(tr('loginError'), tr('PasswordNameUsed'));
          statusRequest = StatusRequest.failure;

          if (hasData) {
            Get.offNamed(AppRoute.userTypePage);
          }
        }
      }
      update();
      print('validate');
    } else {
      print('not validate');
    }
  }

  void loginTeacherWithData() {
    String? jsonString = myServices.sharedPreferences.getString('teacherModel');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString!);
    teacherModel = TeacherModel.fromJson(jsonMap);
    // Use the retrieved object as needed

    name = TextEditingController(text: teacherModel.teacherName);
    password = TextEditingController(text: teacherModel.teacherPassword);

    // validInput(password.text, 8, 50, 'password');
    loginTeacher(true);
  }
}
