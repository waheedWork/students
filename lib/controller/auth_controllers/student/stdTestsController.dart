import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/friendsController.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/core/constant/days.dart';
import 'package:students/core/constant/peroidTime.dart';
import 'package:students/data/model/studentSubjectModel.dart';

import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/student/getStudent.dart';

class StdTestsComeController extends GetxController {
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  late String studentModelId;

  List<StudentSubjectModel> studentALLSubjectsList = [];
  List<bool> comeList = [];
  int comeCount = 0;
  List<StudentSubjectModel> notesList = [];
  List<StudentSubjectModel> testsList = [];
  List<StudentSubjectModel> datesList = [];
  List<String> testsSubjectsNameList = [];
  String sort = '';
  double subjectAvg = 0;
  int subjectCount = 0;
  String periodTime = '';

  @override
  void onInit() {
    periodTime = periodTimeList.first;
    super.onInit();
  }

  getComeList() {
    comeList.clear();
    comeCount = 0;
    for (StudentSubjectModel stdSubject in studentALLSubjectsList) {
      comeList.add(
        stdSubject.studentLessonIsCome.toString() == '1' ? true : false,
      );
      if (stdSubject.studentLessonIsCome.toString() == '0') {
        if (periodTime == periodTimeList.first) {
          comeCount++;
        } else if (periodTime == periodTimeList.last) {
          if (DateTime.now()
                  .difference(DateTime.parse(stdSubject.stdLesDate.toString()))
                  .inDays <=
              7) {
            comeCount++;
          }
        } else {
          if (DateTime.now()
                  .difference(DateTime.parse(stdSubject.stdLesDate.toString()))
                  .inDays <=
              31) {
            comeCount++;
          }
        }
      }
    }
    update();
  }

  getStudentSubjects(String stdId) async {
    studentModelId = stdId;
    statusRequest = StatusRequest.loading;
    update();
    studentALLSubjectsList.clear();
    testsList.clear();
    notesList.clear();
    datesList.clear();
    try {
      var response =
          await studentData.getStudentSubjects(studentId: studentModelId);
      statusRequest = handlingData(response);
      // print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          List list = response['data'];
          for (var element in list) {
            StudentSubjectModel std = StudentSubjectModel.fromJson(element);
            // print(element);
            // print('\n');
            studentALLSubjectsList.add(std);

            datesList.add(std);
            if (datesList
                    .where((element) => element.lessonId == std.lessonId)
                    .length >
                1) {
              datesList.remove(std);
            }
            if (studentALLSubjectsList.last.test.toString() != '') {
              testsList.add(std);
            }
            if (studentALLSubjectsList.last.studentLessonNote.toString() !=
                '') {
              notesList.add(std);
            }
          }
          await datesStudent();
          await getTestsNameSubjectsList();
          await getComeList();
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('getStudentSubjects catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  datesStudent() {
    datesList.sort(
        (a, b) => a.lessonDay.toString().compareTo(b.lessonDay.toString()));
    update();
  }

  void setPeriodTime(String period) {
    periodTime = period;
    getComeList();
    Get.back();
  }

  void setSort(String string) {
    if (sort == string) {
      sort = '';
    } else {
      sort = string;
      subjectAvg = 0;
      subjectCount = 0;
      for (StudentSubjectModel stdTestSubject in testsList) {
        if (stdTestSubject.subjectName == sort) {
          subjectCount++;
          subjectAvg += double.parse(stdTestSubject.test.toString());
        }
      }
      subjectAvg = subjectAvg / subjectCount;
    }
    update();

    update();
  }

  getTestsNameSubjectsList() async {
    testsSubjectsNameList.clear();
    for (var element in studentALLSubjectsList) {
      if (!testsSubjectsNameList.contains(element.subjectName)) {
        testsSubjectsNameList.add(element.subjectName.toString());
      }
    }
    update();
  }

  void toFriendsTestsPage(int index) async {
    Get.toNamed(AppRoute.friendsTestsPage);
    FriendsController friendsController = Get.put(FriendsController());
    await friendsController.getFriendsTests(testsList[index]);
  }
}
