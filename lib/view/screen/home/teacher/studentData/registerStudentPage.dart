import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentsController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/studentTypes.dart';
import 'package:students/core/function/validinput.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

class RegisterStudentPage extends StatelessWidget {
  const RegisterStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentsController studentsController = Get.find();
    // nameTextController = TextEditingController();
    // passwordTextController = TextEditingController();
    // phoneTextController = TextEditingController();
    // parentTextController = TextEditingController();
    // parentPhoneTextController = TextEditingController();
    // typeTextController = TextEditingController();
    // pornDateTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('add_student').tr()),
      body: Center(child: GetBuilder<StudentsController>(
        builder: (controller) {
          return Form(
            key: controller.formState,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      tr('born'),
                                      style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      studentsController
                                          .pornDateTextController.text
                                          .toString(),
                                      style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height / 5,
                              width: Get.width / 1.8,
                              child: YearPicker(
                                // initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime(2018),
                                selectedDate: DateTime(
                                  int.parse(
                                    studentsController
                                        .pornDateTextController.text
                                        .toString(),
                                  ),
                                ),
                                onChanged: (value) {
                                  studentsController.pornDateTextController
                                      .text = value.year.toString();
                                  studentsController.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: List.generate(
                            studentTypes.length,
                            (index) => Expanded(
                              child: InkWell(
                                onTap: () {
                                  studentsController.typeTextController.text =
                                      studentTypes[index];
                                  studentsController.update();
                                },
                                child: Card(
                                  color: studentsController
                                              .typeTextController.text ==
                                          studentTypes[index]
                                      ? Get.theme.primaryColor
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(studentTypes[index])),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AppTextField(
                          type: tr('name'),
                          iconData: Icons.person,
                          inputType: TextInputType.name,
                          onChanged: (p0) {},
                          validator: (p0) {
                            return validInput(p0!, 6, 30, 'password');
                          },
                          textFieldController:
                              studentsController.nameTextController,
                        ),
                        AppTextField(
                          type: tr('password'),
                          iconData: Icons.password,
                          inputType: TextInputType.number,
                          onChanged: (p0) {},
                          obscureText: true,
                          validator: (p0) {
                            return validInput(p0!, 8, 30, 'password');
                          },
                          textFieldController:
                              studentsController.passwordTextController,
                        ),
                        AppTextField(
                          type: tr('phone'),
                          iconData: Icons.phone,
                          inputType: TextInputType.number,
                          onChanged: (p0) {},
                          validator: (p0) {
                            return validInput(p0!, 10, 30, 'password');
                          },
                          textFieldController:
                              studentsController.phoneTextController,
                        ),
                        AppTextField(
                          type: tr('parentName'),
                          iconData: Icons.person_pin_sharp,
                          inputType: TextInputType.name,
                          onChanged: (p0) {},
                          validator: (p0) {
                            return validInput(p0!, 6, 30, 'password');
                          },
                          textFieldController:
                              studentsController.parentTextController,
                        ),
                        AppTextField(
                          type: tr('parentPhone'),
                          iconData: Icons.phone,
                          inputType: TextInputType.number,
                          onChanged: (p0) {},
                          validator: (p0) {
                            return validInput(p0!, 10, 30, 'password');
                          },
                          textFieldController:
                              studentsController.parentPhoneTextController,
                        ),
                        AppTextField(
                          type: tr('studentBay'),
                          iconData: Icons.monetization_on_outlined,
                          inputType: TextInputType.number,
                          onChanged: (p0) {},
                          validator: (p0) {
                            return validInput(p0!, 1, 30, 'password');
                          },
                          textFieldController:
                              studentsController.bayController,
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<StudentsController>(builder: (controller) {
                  return HandelingRequest(
                    statusRequest: controller.statusRequest!,
                    widget: AppSignUpAndLoginButton(
                      text: tr('add'),
                      onPressed: () async {
                        await studentsController.registerStudent();
                      },
                    ),
                  );
                }),
                SizedBox(
                  height: Get.height / 40,
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
