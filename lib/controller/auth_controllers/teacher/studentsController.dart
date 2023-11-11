import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/auth/student/loginDate.dart';
import 'package:students/data/datasource/remote/student_lesson/getStudentLessons.dart';
import 'package:students/data/model/student_lessonModel.dart';
import 'package:students/data/model/student_model.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';

class StudentsController extends GetxController {
  StudentLessonsData studentsLessonData = StudentLessonsData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  List<StudentModel> studentsList = [];
  LoginInfoData loginInfoData = LoginInfoData(Get.find());

  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController parentTextController = TextEditingController();
  TextEditingController parentPhoneTextController = TextEditingController();
  TextEditingController typeTextController = TextEditingController();
  TextEditingController pornDateTextController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController bayController = TextEditingController();

  disposeTexts() {
    nameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    phoneTextController = TextEditingController();
    parentTextController = TextEditingController();
    parentPhoneTextController = TextEditingController();
    typeTextController = TextEditingController();
    pornDateTextController = TextEditingController(text: '2000');
    bayController = TextEditingController();
    update();
  }

  getStudents() async {
    StudentLessonController studentLessonController = Get.find();
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
            bool add = true;
            var stdModel = StudentModel.fromJson(student);
            for (StudentLessonModel studentLesson
                in studentLessonController.studentLessonList) {
              if (studentLesson.studentId == stdModel.studentId.toString()) {
                add = false;
              }
            }
            if (add) {
              studentsList.add(stdModel);
            }
          }
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

  Future<void> addStudentToLesson(int index) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      StudentLessonController studentLessonController = Get.find();
      var response = await studentsLessonData.addFirstComeStudentLessonsData(
        lessonId: studentLessonController.lessonId.toString(),
        studentId: studentsList[index].studentId.toString(),
        studentIsCome: '1',
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(tr('successful'), "");

          // for (var element in studentsList) {
          //   if (studentsList[index].studentId.toString() ==
          //       element.studentId.toString()) {
          //     studentsList.remove(element);
          //   }
          // }
          await studentLessonController
              .getStudentsLesson(studentLessonController.lessonId.toString());
          await getStudents();
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

  bool isRegister = true;

  void toRegisterStudent(String s) {
    if (s == 'update') {
      isRegister = false;
    } else {
      isRegister = true;
    }
    update();
    disposeTexts();
    Get.toNamed(AppRoute.registerPage);
  }

  late GlobalKey<FormState> formState = GlobalKey<FormState>();

  registerStudent() async {
    if (formState.currentState!.validate() &&
        typeTextController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await loginInfoData.registerStudentData(
          studentName: nameTextController.text,
          studentPassword: passwordTextController.text,
          studentCreate: '${now.year}-${now.month}-${now.day}',
          studentPhone: phoneTextController.text,
          studentParentName: parentTextController.text,
          studentParentPhone: parentPhoneTextController.text,
          studentBornDate: pornDateTextController.text,
          studentType: typeTextController.text,
          studentBay: bayController.text,
        );
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            Get.snackbar(tr('successful'), '');
            await getStudents();
          } else {
            Get.snackbar(tr(response['message']), '');
          }
        } else {
          Get.snackbar(tr('connectionError'), "");
        }
      } catch (e) {
        print('getTeacherLessons catch $e');
      }

      update();
      print('validate');
    } else {
      print('not validate');
      Get.snackbar(tr('empty'), '');
    }
  }

  updateStudent() async {
    if (
        // formState.currentState!.validate() &&
        typeTextController.text.isNotEmpty) {
      DateTime now = DateTime.now();
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await loginInfoData.updateStudentData(
          studentId: studentId,
          studentName: nameTextController.text,
          studentPassword: passwordTextController.text,
          studentPhone: phoneTextController.text,
          studentParentName: parentTextController.text,
          studentParentPhone: parentPhoneTextController.text,
          studentBornDate: pornDateTextController.text,
          studentType: typeTextController.text,
          studentBay: bayController.text,
        );
        print(response);
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response.toString().contains('success')) {
          } else {
            Get.snackbar(tr(response['message']), '');
          }
        } else {
          // Get.snackbar(tr('connectionError'), statusRequest.toString());
          Get.back();
          Get.snackbar(tr('successful'), '');
          AllStudentsBayController allStudentsBayController = Get.find();
          await allStudentsBayController.getStudents();
        }
      } catch (e) {
        print('getTeacherLessons catch $e');
      }

      update();
      print('validate');
    } else {
      print('not validate');
      Get.snackbar(tr('empty'), '');
    }
  }

  bool isSearch = false;

  void changeSearchMode() {
    isSearch = !isSearch;
    update();
  }

  void closeSearch() {
    if (searchController.text.isNotEmpty) {
      searchController.clear();
    } else {
      changeSearchMode();
    }
    update();
  }

  String studentId = '-1';

  void setValues(StudentModel studentModel) {
    statusRequest = StatusRequest.loading;
    update();
    studentId = studentModel.studentId.toString();
    nameTextController.text = studentModel.studentName.toString();
    phoneTextController.text = studentModel.studentPhone.toString();
    parentTextController.text = studentModel.studentParentName.toString();
    parentPhoneTextController.text = studentModel.studentParentPhone.toString();
    pornDateTextController.text = studentModel.studentBornDate.toString();
    typeTextController.text = studentModel.studentType.toString();
    bayController.text = studentModel.studentBay.toString();
    statusRequest = StatusRequest.success;
     update();
  }
}
