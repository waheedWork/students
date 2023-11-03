import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentDataController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';
import '../../../data/datasource/remote/bay/studentBayData.dart';
import '../../../data/datasource/remote/student_lesson/getStudentLessons.dart';
import '../../../data/model/student_model.dart';

class AllStudentsBayController extends GetxController {
  List<StudentModel> studentsList = [];

  StatusRequest? statusRequest = StatusRequest.none;
  StudentLessonsData studentsLessonData = StudentLessonsData(Get.find());
  StudentBayData studentBayData = StudentBayData(Get.find());
  String studentId = '';

  getStudents() async {
    statusRequest = StatusRequest.loading;
    update();
    studentsList.clear();
    try {
      var response = await studentsLessonData.getStudentsData();
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (var student in list) {
            var stdModel = StudentModel.fromJson(student);
            studentsList.add(stdModel);
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

  void toBayStudentPage(int index) {
    Get.toNamed(AppRoute.studentBayPage);
    StudentDataController studentDataController =
        Get.put(StudentDataController());
    studentId = studentsList[index].studentId.toString();
    studentDataController
        .getStudentBay(studentsList[index].studentId.toString());
  }

  void addStudentBay(context) {
    TextEditingController quantityController = TextEditingController(text: '');
    Get.defaultDialog(
      title: tr('bay'),
      content: SizedBox(
        height: Get.height / 3,
        child: Column(
          children: [
            Text(
              'bay',
              style: TextStyle(color: Get.theme.primaryColor),
            ).tr(),
            AppTextField(
              auto: true,
              type: tr('bay'),
              iconData: Icons.monetization_on_outlined,
              inputType: TextInputType.number,
              onChanged: (p0) {},
              validator: (p0) {},
              textFieldController: quantityController,
            ),
            AppSignUpAndLoginButton(
              text: tr('add'),
              onPressed: () async {

                await bay(quantityController.text);
              },
            )
          ],
        ),
      ),
    );
  }

  bay(String quantity) async {
    if (quantity.isNotEmpty) {
      Get.back();
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await studentBayData.studentBayData(
          quantity: quantity,
          studentId: studentId,
        );

        statusRequest = handlingData(response);
        print(response);
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            Get.snackbar(tr('successful'), "");
            StudentDataController studentDataController =
                Get.put(StudentDataController());
            await studentDataController.getStudentBay(studentId);
          }
        } else {
          Get.snackbar(tr('connectionError'), "");
        }
      } catch (e) {
        print('getTeacherLessons catch $e');
      }

      statusRequest = StatusRequest.success;
      update();
    }
  }
}
