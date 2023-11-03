import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/teacher/teacherLesson.dart';
import 'package:students/data/model/lessonModel.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';

class TeacherController extends GetxController {
  MyServices myServices = Get.find();
  TeacherLessonData teacherLessonData = TeacherLessonData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;
  late TeacherModel teacherModel;
  List<LessonModel> teacherLessonsList = [];

  @override
  Future<void> onInit() async {
    getTeacherData();
    await getTeacherLessons();
    super.onInit();
  }

  void getTeacherData() {
    String? jsonString = myServices.sharedPreferences.getString('teacherModel');
    Map<String, dynamic> jsonMap = jsonDecode(jsonString!);
    teacherModel = TeacherModel.fromJson(jsonMap);

    update();
  }

  getTeacherLessons() async {
    statusRequest = StatusRequest.loading;
    update();
    teacherLessonsList.clear();
    try {
      var response = await teacherLessonData.teacherLessonData(
        teacherId: teacherModel.teacherId.toString(),
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (Map<String, dynamic> lesson in list) {
            teacherLessonsList.add(LessonModel.fromJson(lesson));
          }
        } else {
          Get.snackbar(tr('connectionError'), "");
        }
      }
    } catch (e) {
      print('getTeacherLessons catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  void toAddLessonPage() {
    Get.toNamed(AppRoute.teacherAddLesson);
  }

  Future<void> toLessonStudentsPage(String lessonId) async {
    Get.toNamed(AppRoute.studentsLessonPage);

    StudentLessonController studentLessonController =
        Get.put(StudentLessonController());
    await studentLessonController.getStudentsLesson(lessonId);
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

  Future<void> toAllStudentsBayPage() async {
    Get.toNamed(AppRoute.allStudentsBayPage);
    AllStudentsBayController studentsController =
        Get.put(AllStudentsBayController());
    await studentsController.getStudents();
  }

  deleteLesson(String lessonId) async {
    Get.back();
    statusRequest = StatusRequest.loading;
    update();
    teacherLessonsList.clear();
    try {
      var response = await teacherLessonData.teacherLessonDelete(
        lessonId: lessonId,
      );
      statusRequest = handlingData(response);
      print('////////////lessonId/////////////');
      print(lessonId);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          await getTeacherLessons();
          Get.snackbar(tr('successfulDelete'), '');
        } else {
          Get.snackbar(tr('connectionError'), "");
        }
      }
    } catch (e) {
      print('getTeacherLessons catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }
}
