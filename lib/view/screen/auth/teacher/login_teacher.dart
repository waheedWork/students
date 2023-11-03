import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/login.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/validinput.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

class LoginTeacherPage extends StatelessWidget {
  const LoginTeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TeacherLoginController(), permanent: true);
    return Scaffold(
      appBar: AppBar(title: const Text('login_teacher').tr()),
      body: Center(
        child: GetBuilder<TeacherLoginController>(
          builder: (teacherController) {
            return Form(
              key: teacherController.formState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextField(
                    type: tr('name'),
                    iconData: Icons.person,
                    inputType: TextInputType.text,
                    onChanged: (p0) {},
                    validator: (p0) {
                      // return validInput(p0!, 4, 50, 'username');
                    },
                    textFieldController: teacherController.name,
                  ),
                  AppTextField(
                    type: tr('password'),
                    obscureText: teacherController.showText,
                    onTap: () {
                      teacherController.changeShow();
                    },
                    iconData: Icons.password,
                    inputType: TextInputType.visiblePassword,
                    onChanged: (p0) {},
                    validator: (p0) {
                      return validInput(p0!, 8, 50, 'password');
                    },
                    textFieldController: teacherController.password,
                  ),
                  HandelingRequest(
                    statusRequest: teacherController.statusRequest!,
                    widget: AppSignUpAndLoginButton(
                      text: tr('login'),
                      onPressed: () async {
                        await teacherController.loginTeacher(false);
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
