import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdTestsController.dart';
import 'package:students/core/class/handelingview.dart';

class NoteModeStudentPage extends StatelessWidget {
  const NoteModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('notes').tr()),
      body: Center(
        child: GetBuilder<StdTestsComeController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.notesList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.notesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            shape: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide:
                                  BorderSide(color: Get.theme.primaryColor),
                            ),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: Get.width / 5,
                                  child: Text(
                                    controller.notesList[index].subjectName
                                        .toString(),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 4,
                                  child: Text(
                                    controller.notesList[index].stdLesDate
                                        .toString(),
                                    style: const TextStyle(fontSize: 8),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              controller.notesList[index].studentLessonNote
                                  .toString(),
                            ),
                            trailing: Text(
                              controller.notesList[index].teacherName
                                  .toString(),
                            ),
                          ),
                        );
                      },
                    )
                  : const Text('noNotes').tr(),
            );
          },
        ),
      ),
    );
  }
}
