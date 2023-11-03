import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/constant/approutes.dart';

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherController teacherController = Get.put(TeacherController());

    Widget lessonCard(int index) {
      return InkWell(
        onLongPress: () {
          Get.defaultDialog(
              title: tr('delete'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await teacherController.deleteLesson(
                        teacherController.teacherLessonsList[index].lessonId
                            .toString(),
                      );
                    },
                    child: const Text('ok').tr(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('back').tr(),
                  ),
                ],
              ));
        },
        onTap: () {
          teacherController.toLessonStudentsPage(
            teacherController.teacherLessonsList[index].lessonId.toString(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            shape: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            textColor: Get.theme.scaffoldBackgroundColor,
            tileColor: Get.theme.primaryColor.withOpacity(0.75),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Get.width / 10,
            ),
            minVerticalPadding: 10,
            title: Text(
              teacherController.teacherLessonsList[index].lessonDay.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: SizedBox(
              width: Get.width / 5,
              child: Text(
                teacherController.teacherLessonsList[index].lessonNote
                    .toString(),
              ),
            ),
            trailing: Text(
              teacherController.teacherLessonsList[index].lessonTime.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }

    drawerWidget() {
      return Column(
        children: [
          InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: teacherController.teacherModel.teacherName.toString(),
                  content: Column(
                    children: [
                      Text(
                        teacherController.teacherModel.teacherPhone.toString(),
                      ),
                      Text(
                        teacherController.teacherModel.subjectName.toString(),
                      ),
                      Text(
                        teacherController.teacherModel.subjectMark.toString(),
                      ),
                    ],
                  ));
            },
            child: ListTile(
              title: const Text(
                'personal',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
          InkWell(
            onTap: () {
              teacherController.toAllStudentsBayPage();
            },
            child: ListTile(
              title: const Text(
                'bay',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
          InkWell(
            onTap: () {
              teacherController.logout();
            },
            child: ListTile(
              title: const Text(
                'logout',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ).tr(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: drawerWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          teacherController.toAddLessonPage();
        },
        child: Icon(
          Icons.add,
          color: Get.theme.backgroundColor,
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('teacher').tr(),
            const SizedBox(
              width: 5,
            ),
            Text(': ${teacherController.teacherModel.teacherName!}'),
          ],
        ),
      ),
      body: Center(
        child: GetBuilder<TeacherController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.teacherLessonsList.isNotEmpty
                  ? RefreshIndicator(
                      color: Get.theme.primaryColor,
                      onRefresh: () async {
                        await controller.getTeacherLessons();
                      },
                      child: ListView.builder(
                        itemCount: controller.teacherLessonsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              lessonCard(index),
                              controller.teacherLessonsList.length == index + 1
                                  ? SizedBox(
                                      height: Get.height / 8,
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('no_lessons').tr(),
                        const SizedBox(
                          height: 33,
                        ),
                        IconButton(
                          onPressed: () async {
                            await teacherController.getTeacherLessons();
                          },
                          icon: const Icon(Icons.refresh),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
