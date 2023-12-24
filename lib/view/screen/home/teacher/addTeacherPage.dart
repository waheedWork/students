import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allTeachersController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/validinput.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

import '../../../widget/auth/apploginbutton.dart';

class AddTeacherPage extends StatelessWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add_teacher').tr(),
      ),
      body: Center(
        child: GetBuilder<AllTeachersController>(
          builder: (teacherController) {
            return Form(
              key: teacherController.formState,
              child: SingleChildScrollView(
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
                      type: tr('phone'),
                      onTap: () {
                
                      },
                      iconData: Icons.phone,
                      inputType: TextInputType.phone,
                      onChanged: (p0) {},
                      validator: (p0) {
                        // return validInput(p0!, 8, 50, 'password');
                      },
                      textFieldController: teacherController.phone,
                    ),
                    AppTextField(
                      type: tr('subject'),
                      onTap: () {

                      },
                      iconData: Icons.subject,
                      inputType: TextInputType.text,
                      onChanged: (p0) {},
                      validator: (p0) {
                        // return validInput(p0!, 8, 50, 'password');
                      },
                      textFieldController: teacherController.subject,
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
                        text: tr('add'),
                        onPressed: () async {
                          await teacherController.addTeacher(false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
