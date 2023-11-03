import 'package:get/get.dart';
import 'package:students/core/middelware.dart';
import 'package:students/view/screen/auth/student/login_student.dart';
import 'package:students/view/screen/auth/teacher/login_teacher.dart';
import 'package:students/view/screen/home/choose_login.dart';
import 'package:students/view/screen/home/load_page.dart';
import 'package:students/view/screen/home/student/studentAllDataPage.dart';
import 'package:students/view/screen/home/student/studentDashboardPage.dart';
import 'package:students/view/screen/home/student/studentModes/bayModeStudentPage.dart';
import 'package:students/view/screen/home/student/studentModes/comeModeStudentPage.dart';
import 'package:students/view/screen/home/student/studentModes/friendsTestsPage.dart';
import 'package:students/view/screen/home/student/studentModes/noteModeStudentPage.dart';
import 'package:students/view/screen/home/student/studentModes/testsModeStudentPage.dart';
import 'package:students/view/screen/home/teacher/dashboard.dart';
import 'package:students/view/screen/home/teacher/studentData/allStudentsBayPage.dart';
import 'package:students/view/screen/home/teacher/studentData/registerStudentPage.dart';
import 'package:students/view/screen/home/teacher/studentData/studentBayPage.dart';
import 'package:students/view/screen/home/teacher/studentData/studentComePage.dart';
import 'package:students/view/screen/home/teacher/studentData/studentDataPage.dart';
import 'package:students/view/screen/home/teacher/studentData/studentLessonsPage.dart';
import 'package:students/view/screen/home/teacher/studentData/studentTestsPage.dart';

import 'core/constant/approutes.dart';
import 'view/screen/home/teacher/addLessonPage.dart';
import 'view/screen/home/teacher/studentData/addStudentLessonPage.dart';
import 'view/screen/home/teacher/studentData/addStudentPage.dart';
import 'view/screen/home/teacher/studentsLessonPage.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: AppRoute.load, page: () => LoadPage(), middlewares: [MiddleWare()]),
  GetPage(
    name: AppRoute.userTypePage,
    page: () => const UserTypePage(),
  ),

  //=====================Student=====================
  GetPage(
    name: AppRoute.loginStudent,
    page: () => const LoginStudentPage(),
  ),
  GetPage(
    name: AppRoute.studentDashboard,
    page: () => const StudentDashboardPage(),
  ),
  GetPage(
    name: AppRoute.subjectsModeStudentPage,
    page: () => const TestsModeStudentPage(),
  ),
  GetPage(
    name: AppRoute.noteModeStudentPage,
    page: () => const NoteModeStudentPage(),
  ),
  GetPage(
    name: AppRoute.bayModeStudentPage,
    page: () => const BayModeStudentPage(),
  ),
  GetPage(
    name: AppRoute.comeModeStudentPage,
    page: () => const ComeModeStudentPage(),
  ),
  GetPage(
    name: AppRoute.friendsTestsPage,
    page: () => const FriendsTestsPage(),
  ),
  GetPage(
    name: AppRoute.allDataStudentPage,
    page: () => const StudentAllDataPage(),
  ),

  //=====================Teacher=====================
  GetPage(
    name: AppRoute.loginTeacher,
    page: () => const LoginTeacherPage(),
  ),
  GetPage(
    name: AppRoute.teacherAddLesson,
    page: () => const TeacherAddLesson(),
  ),
  GetPage(
    name: AppRoute.studentsLessonPage,
    page: () => const StudentsLessonPage(),
  ),
  GetPage(
    name: AppRoute.studentLessonsPage,
    page: () => const StudentLessonsPage(),
  ),
  GetPage(
    name: AppRoute.studentDataPage,
    page: () => const StudentDataPage(),
  ),
  GetPage(
    name: AppRoute.studentBayPage,
    page: () => const StudentBayPage(),
  ),
  GetPage(
    name: AppRoute.allStudentsBayPage,
    page: () => const AllStudentsBayPage(),
  ),
  GetPage(
    name: AppRoute.studentTestsPage,
    page: () => const StudentTestsPage(),
  ),
  GetPage(
    name: AppRoute.addStudent,
    page: () => const AddStudentPage(),
  ),
  GetPage(
    name: AppRoute.registerPage,
    page: () => const RegisterStudentPage(),
  ),
  GetPage(
    name: AppRoute.addStudentLesson,
    page: () => const AddStudentLesson(),
  ),
  GetPage(
    name: AppRoute.studentComePage,
    page: () => const StudentComePage(),
  ),
  GetPage(
    name: AppRoute.teacherDashboard,
    page: () => const TeacherDashboard(),
  ),
];
