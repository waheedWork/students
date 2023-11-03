import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentLessonsController.dart';

class StudentTestsPage extends StatelessWidget {
  const StudentTestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLessonsController studentLessonsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('exams').tr(),
            Expanded(child: Container()),
            Text(
              studentLessonsController.testLessonsList.length.toString(),
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('avg').tr(),
                const SizedBox(width: 30,),
                Text('${studentLessonsController.sum /
                        studentLessonsController.testLessonsList.length} %'),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: studentLessonsController.testLessonsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      color: Get.theme.primaryColor.withOpacity(0.6),
                      child: Text(
                        '${tr('exam_mark')} : ${studentLessonsController.testLessonsList[index].test}',
                      ),
                    ),
                    trailing: Text(
                      studentLessonsController.testLessonsList[index].stdLesDate
                          .toString(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
