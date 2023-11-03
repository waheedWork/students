import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonsController.dart';
import 'package:students/controller/auth_controllers/teacher/studentsController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/function/handlingdata.dart';
import 'package:students/data/datasource/remote/student_lesson/getStudents.dart';

import '../../../core/class/statusrequest.dart';
import '../../../data/model/student_lessonModel.dart';

class StudentLessonController extends GetxController {
  StudentsLessonData studentsLessonData = StudentsLessonData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  List<StudentLessonModel> studentLessonList = [];
  late String lessonId;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  getStudentsLesson(String lesson) async {
    lessonId = lesson;
    statusRequest = StatusRequest.loading;
    update();
    studentLessonList.clear();
    try {
      var response = await studentsLessonData.studentsLessonData(
        lessonId: lessonId,
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (var student in list) {
            studentLessonList.add(StudentLessonModel.fromJson(student));
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

  Future<void> toStudentLessonsPage(
      StudentLessonModel studentLessonModel) async {
    Get.toNamed(AppRoute.studentLessonsPage);
    StudentLessonsController studentLessonsController =
        Get.put(StudentLessonsController());
    await studentLessonsController.getStudentLessons(studentLessonModel);
  }

  Future<void> toAddStudent() async {
    Get.toNamed(AppRoute.addStudent);
    StudentsController studentsController=Get.put(StudentsController());
   await studentsController.getStudents();
  }

  deleteStudent(StudentLessonModel studentLessonList) async {
    Get.back();
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await studentsLessonData.studentsLessonDelete(
        lessonId: studentLessonList.lessonId.toString(),
        studentId: studentLessonList.studentId.toString(),
      );
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          await getStudentsLesson(lessonId);
          Get.snackbar(tr('successfulDelete'), '');
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
