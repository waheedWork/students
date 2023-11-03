import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class StudentData {
  Crud crud;

  StudentData(this.crud);

  getStudentData({
    required String studentId,
  }) async {
    var response = await crud.postData(
      AppLinks.getStudentIdLink,
      {
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  getStudentBay({required studentId}) async {
    var response = await crud.postData(
      AppLinks.getStudentBayLink,
      {
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
  getStudentSubjects({required studentId}) async {
    var response = await crud.postData(
      AppLinks.getStudentSubjectsLink,
      {
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
