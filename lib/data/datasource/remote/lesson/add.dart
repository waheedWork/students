import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class AddLessonData {
  Crud crud;

  AddLessonData(this.crud);

  addLessonData({
    required String teacherId,
    required String time,
    required String period,
    required String day,
    required String note,
  }) async {
    var response = await crud.postData(
      AppLinks.addLessonLink,
      {
        'teacher_id': teacherId,
        'lesson_time': time,
        'lesson_period': period,
        'lesson_day': day,
        'lesson_note': note,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
