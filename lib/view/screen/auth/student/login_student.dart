import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/login.dart';

import '../../../../core/class/handelingview.dart';
import '../../../../core/function/validinput.dart';
import '../../../widget/auth/apploginbutton.dart';
import '../../../widget/auth/apptextfield.dart';

class LoginStudentPage extends StatelessWidget {
  const LoginStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StudentLoginController());
    return Scaffold(
      appBar: AppBar(title: const Text('login_student').tr()),
      body: Center(
        child: GetBuilder<StudentLoginController>(
          builder: (studentController) {
            return Form(
              key: studentController.formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  AppTextField(
                    type: tr('password'),
                    obscureText: studentController.showText,
                    onTap: () {
                      studentController.changeShow();
                    },
                    iconData: Icons.password,
                    inputType: TextInputType.visiblePassword,
                    onChanged: (p0) {},
                    validator: (p0) {
                      return validInput(p0!, 8, 50, 'password');
                    },
                    textFieldController: studentController.password,
                  ),
                  HandelingRequest(
                    statusRequest: studentController.statusRequest!,
                    widget: AppSignUpAndLoginButton(
                      text: tr('login'),
                      onPressed: () async {
                        await studentController.loginStudent(false);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
