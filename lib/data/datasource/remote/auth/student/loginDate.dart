import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class LoginInfoData {
  Crud crud;

  LoginInfoData(this.crud);

  loginInfoData({
    required String password,
  }) async {
    var response = await crud.postData(
      AppLinks.loginStudentLink,
      {
        'student_password': password,
      },
    );
    return response.fold((l) => l, (r) => r);
  }

  registerStudentData({
    required String studentName,
    required String studentPassword,
    required String studentCreate,
    required String studentPhone,
    required String studentParentName,
    required String studentParentPhone,
    required String studentBornDate,
    required String studentType,
    required String studentBay,
  }) async {
    var response = await crud.postData(
      AppLinks.registerStudentLink,
      {
        'student_name': studentName,
        'student_password': studentPassword,
        'student_create': studentCreate,
        'student_phone': studentPhone,
        'student_parent_name': studentParentName,
        'student_parent_phone': studentParentPhone,
        'student_born_date': studentBornDate,
        'student_type': studentType,
        'student_bay': studentBay,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
