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
    AllTeachersController allTeachersController = Get.find();

    customSubjectBtn(
        Null Function() param0, String subject, String subjectNum) {
      return InkWell(
        onTap: (){
          param0();
          allTeachersController.update();
        },
        child: Card(
          color: subjectNum == allTeachersController.subject.text
              ? Get.theme.scaffoldBackgroundColor
              : Get.theme.canvasColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              subject,
              style: TextStyle(
                color: subjectNum != allTeachersController.subject.text
                    ? Get.theme.scaffoldBackgroundColor
                    : Get.theme.canvasColor,
              ),
            ),
          ),
        ),
      );
    }

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
                      onTap: () {},
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
                      onTap: () {},
                      readOnly: true,
                      iconData: Icons.subject,
                      inputType: TextInputType.text,
                      onChanged: (p0) {},
                      validator: (p0) {
                        // return validInput(p0!, 8, 50, 'password');
                      },
                      textFieldController: teacherController.subject,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '5';
                              },
                              'فيزياء',
                              '5',
                            ),
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '6';
                              },
                              'رياضيات',
                              '6',
                            ),
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '8';
                              },
                              'انكليزي',
                              '8',
                            ),
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '9';
                              },
                              'فرنسي',
                              '9',
                            ),
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '12';
                              },
                              'قومية',
                              '12',
                            ),
                            customSubjectBtn(
                              () {
                                teacherController.subject.text = '13';
                              },
                              'علوم',
                              '13',
                            ),
                          ],
                        ),
                      ),
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
