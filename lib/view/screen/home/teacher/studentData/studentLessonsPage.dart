import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonsController.dart';
import 'package:students/core/class/handelingview.dart';

class StudentLessonsPage extends StatelessWidget {
  const StudentLessonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLessonsController studentLessonsController =
        Get.put(StudentLessonsController());

    Widget lessonCard(int index) {
      return Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${tr('lesson')} ${index + 1}',
              ),
              Text(
                studentLessonsController.studentLessonsList[index].stdLesDate
                    .toString(),
              ),
            ],
          ),
          ListTile(
            // leading: ,
            title: Text(
              '${tr('level')} : ${studentLessonsController.studentLessonsList[index].level}',
            ),
            subtitle: Text(
              '${tr('note')} : ${studentLessonsController.studentLessonsList[index].studentLessonNote}',
            ),
            trailing: studentLessonsController.studentLessonsList[index].late
                        .toString() ==
                    ''
                ? null
                : Text(
                    '${tr("late")}  ${studentLessonsController.studentLessonsList[index].late} ${tr("minute")} ',
                  ),
          ),
          studentLessonsController.studentLessonsList[index].test != ''
              ? Container(
                  color: Colors.greenAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${tr("exam_mark")}  ${studentLessonsController.studentLessonsList[index].test}'),
                  ),
                )
              : Container(),
          studentLessonsController
                      .studentLessonsList[index].studentLessonIsCome ==
                  '0'
              ? Container(
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tr("isNotCome")),
                  ),
                )
              : Container(),
        ],
      );
    }

    drawerColumn() {
      return Column(
        children: [
          SizedBox(
            height: Get.height / 10,
            child: Text(
              studentLessonsController.studentLessonModel.studentName
                  .toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              studentLessonsController.toStudentDataPage(
                studentLessonsController.studentLessonModel.studentId
                    .toString(),
              );
            },
            child: ListTile(
              title: const Text('personal').tr(),
            ),
          ),
          InkWell(
            onTap: () {
              studentLessonsController.toStudentBayPage(
                studentLessonsController.studentLessonModel,
              );
            },
            child: ListTile(
              title: const Text('bay').tr(),
            ),
          ),
          InkWell(
            onTap: () {
              studentLessonsController.toStudentTestsPage();
            },
            child: ListTile(
              title: const Text('exams').tr(),
            ),
          ),
          InkWell(
            onTap: () {
              studentLessonsController.toStudentComePage();
            },
            child: ListTile(
              title: const Text('attend').tr(),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: drawerColumn(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            studentLessonsController.toAddStudentLessonPage();
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('lessons').tr(),
            Expanded(child: Container()),
            Text(
              studentLessonsController.studentLessonModel.studentName
                  .toString(),
            ),
          ],
        ),
      ),
      body: Center(
        child: GetBuilder<StudentLessonsController>(
          builder: (controller) {
            return HandelingRequest(
                statusRequest: controller.statusRequest!,
                widget: controller.studentLessonsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.studentLessonsList.length,
                        itemBuilder: (context, index) {
                          return lessonCard(index);
                        },
                      )
                    : const Text('no_lessons').tr());
          },
        ),
      ),
    );
  }
}
