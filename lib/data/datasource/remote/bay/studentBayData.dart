import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class StudentBayData {
  Crud crud;

  StudentBayData(this.crud);

  studentBayData({
    required String quantity,
    required String studentId,
  }) async {
    var response = await crud.postData(
      AppLinks.bayStudentLink,
      {
        'quantity': quantity,
        'student_id': studentId,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
