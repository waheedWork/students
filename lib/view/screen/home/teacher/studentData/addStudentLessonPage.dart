import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonsController.dart';
import 'package:students/controller/auth_controllers/teacher/studentsController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

import '../../../../../controller/auth_controllers/teacher/teacherController.dart';

class AddStudentLesson extends StatelessWidget {
  const AddStudentLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLessonsController studentLessonsController = Get.find();

    TeacherController teacherController = Get.find();
    comeWidget() {
      return InkWell(
        onTap: () {
          studentLessonsController.isComeChange();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              studentLessonsController.isCome ? 'isCome' : 'isNotCome',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            Switch(
              splashRadius: Get.width / 4,
              value: studentLessonsController.isCome,
              onChanged: (value) {
                studentLessonsController.isComeChange();
              },
            ),
          ],
        ),
      );
    }

    isExamWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            studentLessonsController.isExam ? 'exam_mark' : 'not_exam',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
          Switch(
            splashRadius: Get.width / 4,
            value: studentLessonsController.isExam,
            onChanged: (value) {
              studentLessonsController.isExamChange();
            },
          ),
        ],
      );
    }


    levelWidget() {
      String mark = teacherController.teacherModel.subjectMark.toString();
      return Row(
        children: [
          Column(
            children: [
              Text(studentLessonsController.isExam ? 'exam_mark' : 'level')
                  .tr(),
              Text(
                '${studentLessonsController.level.text} / $mark',
              ),
            ],
          ),
          Expanded(
            child: Slider(
              min: 0,
              max: double.parse(mark),
              divisions: int.parse(mark)*2,
              value: double.parse(
                studentLessonsController.level.text,
              ),
              label: '${studentLessonsController.level.text} / $mark',
              onChanged: (value) {
                studentLessonsController.level.text = value.toStringAsFixed(2);
                studentLessonsController.update();
              },
            ),
          ),
        ],
      );
    }

    lateWidget() {
      return SizedBox(
        height: Get.height / 6,
        child: Row(
          children: [
            const Text('late').tr(),
            Expanded(
              child: CupertinoTimerPicker(
                minuteInterval: 5,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (value) {
                  studentLessonsController.late.text =
                      value.inMinutes.toString();
                },
              ),
            ),
          ],
        ),
      );
    }
    noteWidget() {
      return AppTextField(
        lines: 3,
        type: tr('note'),
        iconData: Icons.note,
        inputType: TextInputType.text,
        onChanged: (p0) {},
        validator: (p0) {},
        textFieldController: studentLessonsController.note,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('add_lesson').tr(),
            Text(
              studentLessonsController.studentLessonModel.studentName
                  .toString(),
            ),
          ],
        ),
      ),
      body: Center(
        child: GetBuilder<StudentLessonsController>(builder: (controller) {
          return Column(
            children: [
              comeWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: studentLessonsController.isCome
                            ? Get.height / 1.2
                            : 0,
                        width: Get.width / 1.1,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Divider(),
                              lateWidget(),
                              const Divider(),
                              isExamWidget(),
                              levelWidget(),
                              const Divider(),
                              noteWidget(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder<StudentLessonsController>(
                builder: (controller) {
                  return HandelingRequest(
                    statusRequest: studentLessonsController.statusRequest!,
                    widget: AppSignUpAndLoginButton(
                      text: tr('add'),
                      onPressed: () async {
                        await studentLessonsController.addStudentLesson();
                      },
                    ),
                  );
                }
              ),
              SizedBox(
                height: Get.height / 90,
              ),
            ],
          );
        }),
      ),
    );
  }
}
