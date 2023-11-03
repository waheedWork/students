import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/auth_controllers/teacher/studentLessonsController.dart';

class StudentComePage extends StatelessWidget {
  const StudentComePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentLessonsController studentLessonsController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('isNotCome').tr(),
            Expanded(child: Container()),
            Text(
              studentLessonsController.notComeLessonsList.length.toString(),
              style: const TextStyle(color: Colors.red),
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
                const SizedBox(
                  width: 30,
                ),
                Text(
                    '${(studentLessonsController.notComeLessonsList.length / studentLessonsController.studentLessonsList.length) * 100} %'),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: studentLessonsController.notComeLessonsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      color: Colors.red,
                      child: Text(
                        tr('isNotCome'),
                      ),
                    ),
                    trailing: Text(
                      studentLessonsController.notComeLessonsList[index].stdLesDate
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
