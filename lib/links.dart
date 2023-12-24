class AppLinks {
  static const String serverLink = 'https://waheedoofordersnow.000webhostapp.com/students';






  //==================== Teacher ======================
  static const String signUpLink        = '$serverLink/auth/signup.php';
  static const String loginLink         = '$serverLink/auth/login_teacher.php';
  static const String getTeacherLessonLink         = '$serverLink/lesson/getTeacherLesson.php';
  static const String getStudentIdLink         = '$serverLink/student/getStudent.php';
  static const String getAllTeachersLink         = '$serverLink/auth/getAllTeachers.php';


  //==================== Lesson ======================
  static const String addLessonLink         = '$serverLink/lesson/add.php';
  static const String deleteTeacherLessonLink         = '$serverLink/lesson/delete.php';

  //==================== Student Lesson ======================
  static const String getStudentsLink         = '$serverLink/lesson_student/getStudents.php';
  static const String getStudentLessonsLink         = '$serverLink/lesson_student/getStudentLessons.php';
  static const String addStudentLessonLink         = '$serverLink/lesson_student/add.php';
  static const String deleteStudentLessonLink         = '$serverLink/lesson_student/delete.php';
  static const String deleteStudentLessonsLink         = '$serverLink/lesson_student/deleteStudent.php';
  static const String getStudentsNotIn         = '$serverLink/lesson_student/getStudentsNotIn.php';
  static const String getStudentFriendTests         = '$serverLink/lesson_student/getFriendsTests.php';


  //==================== Student ======================
  static const String loginStudentLink         = '$serverLink/student/loginInfo.php';
  static const String getStudentBayLink      = '$serverLink/bay/getSum.php';
  static const String registerStudentLink      = '$serverLink/student/signupStudents.php';
  static const String updateStudentLink      = '$serverLink/student/update.php';
  static const String bayStudentLink      = '$serverLink/bay/add.php';
  static const String bayDeleteStudentLink      = '$serverLink/bay/delete.php';
  static const String getStudentSubjectsLink      = '$serverLink/lesson_student/getStudentLessonsData.php';
}
