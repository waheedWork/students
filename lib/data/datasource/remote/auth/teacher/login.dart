import '../../../../../core/class/crud.dart';
import '../../../../../links.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  loginData({
    required String name,
    required String password,
  }) async {
    var response = await crud.postData(
      AppLinks.loginLink,
      {
        'teacher_password': password,
        'teacher_name': name,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
