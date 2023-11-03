import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/time_picker.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/data/datasource/remote/lesson/add.dart';
import 'package:students/data/model/lessonModel.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';

class LessonController extends GetxController {
  LessonModel addedLessonModel = LessonModel();
  Duration initDuration = const Duration(minutes: 60);
  StatusRequest? statusRequest = StatusRequest.none;
  DateTime initTime = DateTime(DateTime.now().year, 1, 1, 8, 0);
  AddLessonData addLessonData = AddLessonData(Get.find());
  TeacherController teacherController = Get.find();
  TextEditingController noteController = TextEditingController(text: "");

  @override
  void onInit() {
    addedLessonModel.lessonPeriod = initDuration.inMinutes.toString();
    addedLessonModel.lessonTime = DateFormat.jms('en').format(initTime);
    addedLessonModel.lessonNote = '';

    super.onInit();
  }

  void setDay(day) {
    addedLessonModel.lessonDay = day;
    update();
    print(addedLessonModel);
  }

  setTime(value) {
    print(value);
    addedLessonModel.lessonTime = value;
  }

  setDuration(Duration value) {
    addedLessonModel.lessonPeriod = value.inMinutes.toString();
  }

  void setNote(String value) {
    addedLessonModel.lessonNote = noteController.text;
  }

  Future<void> addLesson() async {
    if (addedLessonModel.lessonDay.toString() != 'null'
        ) {
      if(noteController.text.isNotEmpty){
        statusRequest = StatusRequest.loading;
        update();

        try {
          var response = await addLessonData.addLessonData(
            teacherId: teacherController.teacherModel.teacherId.toString(),
            time: addedLessonModel.lessonTime.toString(),
            period: addedLessonModel.lessonPeriod.toString(),
            day: addedLessonModel.lessonDay.toString(),
            note: addedLessonModel.lessonNote.toString(),
          );
          statusRequest = handlingData(response);
          print(response);
          if (statusRequest == StatusRequest.success) {
            if (response['status'] == 'success') {
              Get.back();
              await teacherController.getTeacherLessons();
            } else {
              Get.snackbar(tr(response['message']), "");
            }
          }
        } catch (e) {
          Get.snackbar(tr('connectionError'), "");
          print('getTeacherLessons catch $e');
        }
        statusRequest = StatusRequest.success;
        update();
      }else{
        Get.snackbar(tr('kind'), "");

      }

    } else {
      Get.snackbar(tr('day'), "");
    }
  }
}
