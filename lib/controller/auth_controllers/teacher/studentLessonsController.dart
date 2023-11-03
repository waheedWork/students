import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/controller/auth_controllers/teacher/login.dart';
import 'package:students/controller/auth_controllers/teacher/studentDataController.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/handlingdata.dart';
import 'package:students/data/model/student_model.dart';

import '../../../core/class/statusrequest.dart';
import '../../../data/datasource/remote/student_lesson/getStudentLessons.dart';
import '../../../data/model/student_lessonModel.dart';

class StudentLessonsController extends GetxController {
  StudentLessonsData studentLessonsData = StudentLessonsData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  List<StudentLessonModel> studentLessonsList = [];
  late StudentLessonModel studentLessonModel;

  StudentDataController studentDataController =
      Get.put(StudentDataController());

  TextEditingController level = TextEditingController();
  TextEditingController late = TextEditingController();
  TextEditingController note = TextEditingController();
  bool isCome = false;
  bool isExam = false;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  isComeChange() {
    isCome = !isCome;
    // if (!isCome) {
    //   disposeValues();
    // }
    update();
  }

  isExamChange() {
    isExam = !isExam;
    // if (!isCome) {
    //   disposeValues();
    // }
    update();
  }

  void disposeValues() {
    level = TextEditingController(text: '0');
    late = TextEditingController(text: '0');
    note = TextEditingController();
    isCome = false;
    isExam = false;
    update();
  }

  getStudentLessons(StudentLessonModel studentLesson) async {
    studentLessonModel = studentLesson;
    statusRequest = StatusRequest.loading;
    update();
    studentLessonsList.clear();
    try {
      var response = await studentLessonsData.studentLessonsData(
        lessonId: studentLessonModel.lessonId.toString(),
        studentId: studentLessonModel.studentId.toString(),
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (var student in list) {
            studentLessonsList.add(StudentLessonModel.fromJson(student));
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

  void toStudentDataPage(String studentId) {
    studentDataController.getStudentData(studentId);
    Get.toNamed(AppRoute.studentDataPage);
  }

  void toStudentBayPage(StudentLessonModel studentMId) {
    Get.toNamed(AppRoute.studentBayPage);
    AllStudentsBayController allStudentsBayController =
        Get.put(AllStudentsBayController());
    allStudentsBayController.studentId = studentMId.studentId.toString();
    studentDataController.getStudentBay(studentMId.studentId.toString());
  }

  double sum = 0;
  List<StudentLessonModel> testLessonsList = [];

  void toStudentTestsPage() {
    sum = 0;
    testLessonsList = [];
    for (StudentLessonModel studentLesson in studentLessonsList) {
      if (studentLesson.test != '') {
        sum += double.parse(studentLesson.test.toString());
        testLessonsList.add(studentLesson);
      }
    }
    Get.toNamed(AppRoute.studentTestsPage);
  }

  List<StudentLessonModel> notComeLessonsList = [];

  void toStudentComePage() {
    notComeLessonsList = [];
    for (StudentLessonModel studentLesson in studentLessonsList) {
      if (studentLesson.studentLessonIsCome != '1') {
        notComeLessonsList.add(studentLesson);
      }
    }
    Get.toNamed(AppRoute.studentComePage);
  }

  void toAddStudentLessonPage() {
    // print(studentLessonModel.lessonId);
    disposeValues();
    Get.toNamed(AppRoute.addStudentLesson);
  }

  addStudentLesson() async {
    statusRequest = StatusRequest.loading;
    update();
    var res;
    print('${level.text} ${late.text} ${note.text} $isCome');
    try {
      if (isCome) {
        res = await studentLessonsData.addStudentLessonsData(
          lessonId: studentLessonModel.lessonId.toString(),
          studentId: studentLessonModel.studentId.toString(),
          studentTest: isExam ? level.text : '',
          studentLevel: level.text,
          studentLate: late.text == '0' ? '' : late.text,
          studentStudentNote: note.text,
          studentLessonIsCome: '1',
        );
      } else {
        res = await studentLessonsData.addFirstComeStudentLessonsData(
          lessonId: studentLessonModel.lessonId.toString(),
          studentId: studentLessonModel.studentId.toString(),
          studentIsCome: '0',
        );
      }

      var response = res;
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.back();
          Get.snackbar(tr('successful'), "");
          await getStudentLessons(studentLessonModel);
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
