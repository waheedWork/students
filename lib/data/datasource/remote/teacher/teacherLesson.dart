import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class TeacherLessonData {
  Crud crud;

  TeacherLessonData(this.crud);

  teacherLessonData({
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.getTeacherLessonLink,
      {
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  teacherLessonDelete({required String lessonId}) async {
    var response = await crud.postData(
      AppLinks.deleteTeacherLessonLink,
      {
        'lesson_id': lessonId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}

class TeacherListData {
  Crud crud;

  TeacherListData(this.crud);

  teachersListData({required String teacherId}) async {
    var response = await crud.postData(
      AppLinks.getAllTeachersLink,
      {
        'teacher_id': '12312312',
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  teacherAddData({
    required String teacher_name,
    required String teacher_phone,
    required String teacher_password,
    required String subject_id,
  }) async {
    var response = await crud.postData(
      AppLinks.addTeacherLink,
      {
        'teacher_name': teacher_name,
        'teacher_phone': teacher_phone,
        'teacher_password': teacher_password,
        'subject_id': subject_id,
      },
    );
    return response.fold((l) => l, (r) => r);
  }


  deleteStudentLessonData({
    required String teacherId,
  }) async {
    var response = await crud.postData(
      AppLinks.deleteTeacherLink,
      {
        'teacher_id': teacherId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
