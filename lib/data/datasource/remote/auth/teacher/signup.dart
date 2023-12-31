import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class SignUpData {
  Crud crud;

  SignUpData(this.crud);

  signUpUser({
    required String username,
    required String subjectId,
    required String password,
    required String phone,
  }) async {
    var response = await crud.postData(
      AppLinks.signUpLink,
      {
        'username': username,
        'password': password,
        'phone': phone,
        'subject_id': subjectId
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
