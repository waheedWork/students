import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class StudentLessonsData {
  Crud crud;

  StudentLessonsData(this.crud);

  studentLessonsData({
    required String lessonId,
    required String studentId,
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentLessonsLink,
      {
        'lesson_id': lessonId,
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  getStudentsData() async {
    var response = await crud.postData(
      AppLinks.getStudentsNotIn,
      {
        // 'lesson_id': lessonId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  addStudentLessonsData({
    required String lessonId,
    required String studentId,
    required String studentTest,
    required String studentLevel,
    required String studentLate,
    required String studentStudentNote,
    required String studentLessonIsCome,
  }) async {
    var response = await crud.postData(
      AppLinks.addStudentLessonLink,
      {
        'student_id': studentId,
        'lesson_id': lessonId,
        'test': studentTest,
        'level': studentLevel,
        'late': studentLate,
        'student_lesson_note': studentStudentNote,
        'student_lesson_isCome': studentLessonIsCome,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  addFirstComeStudentLessonsData({
    required String lessonId,
    required String studentId,
    required String studentIsCome,
  }) async {
    var response = await crud.postData(
      AppLinks.addStudentLessonLink,
      {
        'student_id': studentId,
        'lesson_id': lessonId,
        'test': '',
        'level': '',
        'late': '',
        'student_lesson_note': '',
        'student_lesson_isCome': studentIsCome,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  getStudentFriendTestsData({
    required String lessonId,
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentFriendTests,
      {
        'lesson_id': lessonId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
