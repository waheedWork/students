import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/checkinternet.dart';
import '../../../core/function/handlingdata.dart';
import '../../../data/datasource/remote/teacher/teacherLesson.dart';

class AllTeachersController extends GetxController {
  TeacherListData teacherListData = TeacherListData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  List<TeacherModel> teachersModelList = [];
  late GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool showText = true;

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController subject = TextEditingController();

  void changeShow() {
    showText = !showText;
    update();
  }

  @override
  Future<void> onInit() async {
    await getTeachersList();
    super.onInit();
  }

  getTeachersList() async {
    statusRequest = StatusRequest.loading;
    update();
    teachersModelList.clear();
    try {
      var response = await teacherListData.teachersListData(
        teacherId: '3432432424',
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (Map<String, dynamic> teacher in list) {
            teachersModelList.add(TeacherModel.fromJson(teacher));
            print('teachersModelList.last.teacherName.toString()');
            print(teachersModelList.last.teacherName.toString());
            update();
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

  addTeacher(bool bool) async {
    statusRequest = StatusRequest.loading;
    update();
    if (formState.currentState!.validate() &&
        name.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        password.text.isNotEmpty &&
        subject.text.isNotEmpty) {
      try {
        if (await checkInternet()) {
          var response = await teacherListData.teacherAddData(
            teacher_name: name.text,
            teacher_phone: phone.text,
            teacher_password: password.text,
            subject_id: subject.text,
          );
          statusRequest = handlingData(response);
          print('response');
          print(response);
          if (statusRequest == StatusRequest.success) {
            if (response['status'] == 'success') {
              Get.back();
              await getTeachersList();
            } else {
              Get.snackbar(tr(response['message']), "");
            }
          }
        } else {
          Get.snackbar(tr('connectionError'), "");
        }
      } catch (e) {
        Get.snackbar(tr('empty'), "");
        print('addTeacher catch $e');
      }
      statusRequest = StatusRequest.success;
      update();
    } else {
      Get.snackbar(tr('empty'), "");
    }

    statusRequest = StatusRequest.success;
    update();
  }

  deleteTeacher(String teacherId) async {
    print('deleteTeacher');
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response =
          await teacherListData.deleteStudentLessonData(teacherId: teacherId);
      statusRequest = handlingData(response);
      print(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(tr('successfulDelete'), "");
          await getTeachersList();
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('deleteTeacher catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }
}
