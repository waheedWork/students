import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/lessonController.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/days.dart';

class TeacherAddLesson extends StatelessWidget {
  const TeacherAddLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.find();
    LessonController lessonController = Get.put(LessonController());
    chooseDay() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            weekDays.length,
            (index) => InkWell(
              onTap: () {
                lessonController.setDay(weekDays[index]);
              },
              child: Card(
                color: lessonController.addedLessonModel.lessonDay ==
                        weekDays[index]
                    ? Get.theme.primaryColor.withOpacity(0.8)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  child: Text(weekDays[index],
                      style: TextStyle(
                        color: lessonController.addedLessonModel.lessonDay ==
                                weekDays[index]
                            ? Get.theme.backgroundColor.withOpacity(0.8)
                            : null,
                      )),
                ),
              ),
            ),
          ),
        ),
      );
    }

    addNote() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        child: TextFormField(
          maxLines: 2,
          onChanged: (value) {
            lessonController.setNote(value);
          },
          decoration: InputDecoration(
            hintText: tr('kind'),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
          ),
          controller: lessonController.noteController,
        ),
      );
    }

    chooseTime() {
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        height: Get.height / 3.5,
        width: Get.width / 3,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                minuteInterval: 15,
                use24hFormat: false,
                mode: CupertinoDatePickerMode.time,
                initialDateTime: lessonController.initTime,
                onDateTimeChanged: (DateTime value) {
                  lessonController.setTime(DateFormat.jms('en').format(value));
                  print(DateFormat('hh-mm').format(value));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('time').tr(),
            ),
          ],
        ),
      );
    }

    chooseDuration() {
      return Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        height: Get.height / 3.5,
        width: Get.width / 2,
        child: Column(
          children: [
            Expanded(
              child: CupertinoTimerPicker(
                initialTimerDuration: lessonController.initDuration,
                minuteInterval: 15,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (value) =>
                    lessonController.setDuration(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('period').tr(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await lessonController.addLesson();
        },
        child: GetBuilder<LessonController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: const Icon(Icons.done),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          '${tr("add_lesson")} ${teacherController.teacherModel.teacherName}',
        ),
      ),
      body: GetBuilder<LessonController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'day',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ).tr(),
                    ),
                    chooseDay(),
                    Divider(height: Get.height / 33, thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ).tr(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        chooseTime(),
                        chooseDuration(),
                      ],
                    ),
                    Divider(height: Get.height / 33, thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'kind',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ).tr(),
                    ),
                    addNote(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
