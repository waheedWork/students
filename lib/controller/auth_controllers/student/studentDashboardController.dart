import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdBayController.dart';
import 'package:students/controller/auth_controllers/student/stdTestsController.dart';
import 'package:students/data/model/student_model.dart';

import '../../../core/constant/approutes.dart';
import '../../../core/services/services.dart';

class StudentDashboardController extends GetxController {
  MyServices myServices = Get.find();
  StudentModel studentModel = StudentModel();

  StdTestsComeController controller = Get.put(StdTestsComeController());

  @override
  Future<void> onInit() async {
    getStudentData();
    await controller.getStudentSubjects(studentModel.studentId.toString());
    super.onInit();
  }

  void getStudentData() {
    String? jsonString = myServices.sharedPreferences.getString('studentModel');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString!);
    studentModel = StudentModel.fromJson(jsonMap);
    update();
  }

  void logout() {
    Get.defaultDialog(
      title: tr('logout'),
      content: TextButton(
        onPressed: () {
          myServices.sharedPreferences.clear();
          Get.offAllNamed(AppRoute.userTypePage);
        },
        child: const Text('ok').tr(),
      ),
    );
  }

  Future<void> toStudentBayPage() async {
    Get.toNamed(AppRoute.bayModeStudentPage);
    StdBayController controller = Get.put(StdBayController());
    await controller.getStudentBay(studentModel.studentId.toString());
  }

  Future<void> toStudentSubjectsComesPage() async {
    await controller.getComeList();
    Get.toNamed(AppRoute.comeModeStudentPage);
  }

  void toStudentSubjectsNotesPage() {
    Get.toNamed(AppRoute.noteModeStudentPage);
  }

  void toStudentSubjectsTestsPage() async {
    Get.toNamed(AppRoute.subjectsModeStudentPage);
    StdTestsComeController stdTestsComeController = Get.find();
    stdTestsComeController.setSort('');
  }

  void toStudentAllDataPage() {
    Get.toNamed(AppRoute.allDataStudentPage);
  }
}
