import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/auth/student/loginDate.dart';
import 'package:students/data/model/student_model.dart';
import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';

class StudentLoginController extends GetxController {
  TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginInfoData loginData = LoginInfoData(Get.find());
  MyServices myServices = Get.find();
  StudentModel studentModel = StudentModel();

  changeShow() {
    showText = !showText;
    update();
  }

  loginStudent(bool hasData) async {
    if (hasData || formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.loginInfoData(
        password: password.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          studentModel = StudentModel.fromJson(response['data']);
          studentModel.studentPassword = password.text;
          String jsonString = jsonEncode(studentModel.toJson());
          await myServices.sharedPreferences
              .setString('studentModel', jsonString);
          myServices.sharedPreferences.setString('step', '2');
          myServices.sharedPreferences.setString('step', '2');
          statusRequest = StatusRequest.success;
          update();
          Get.offAllNamed(AppRoute.studentDashboard);
        } else {
          Get.snackbar(tr('loginError'), tr('PasswordError'));
          statusRequest = StatusRequest.failure;
          if (hasData) {
            Get.offNamed(AppRoute.userTypePage);
          }
        }
      } else {
        Get.snackbar(tr('connectionError'), '');
      }
      update();
      print('validate');
    } else {
      print('not validate');
    }
  }

  void loginStudentWithData() async {
    String? jsonString = myServices.sharedPreferences.getString('studentModel');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString!);
    studentModel = StudentModel.fromJson(jsonMap);
    // Use the retrieved object as needed

    password = TextEditingController(text: studentModel.studentPassword);

    // password = TextEditingController(
    //     text: myServices.sharedPreferences.getStringList('studentModel')![2]);

    // validInput(password.text, 8, 50, 'password');
    await loginStudent(true);
  }
}
