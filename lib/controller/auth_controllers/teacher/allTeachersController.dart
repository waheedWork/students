import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:students/data/model/teacher_model.dart';

import '../../../core/class/statusrequest.dart';
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
    showText =!showText;
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

  addTeacher(bool bool) {}

}
