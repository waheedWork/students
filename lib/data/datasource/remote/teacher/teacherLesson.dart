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
}
