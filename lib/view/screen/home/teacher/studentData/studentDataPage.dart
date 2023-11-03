import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/class/handelingview.dart';

import '../../../../../controller/auth_controllers/teacher/studentDataController.dart';

class StudentDataPage extends StatelessWidget {
  const StudentDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDataController studentDataController = Get.find();
    return Scaffold(
      appBar: AppBar(title: const Text('student').tr()),
      body: Center(
        child: GetBuilder<StudentDataController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: Column(
                children: [
                  const Text('student').tr(),
                  ListTile(
                    title: Text(
                      controller.studentModel.studentName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                    subtitle: Text(
                      controller.studentModel.studentCreate.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                    trailing: Text(
                      controller.studentModel.studentPhone.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  const Divider(
                    height: 30,
                  ),
                  const Text('parent').tr(),
                  ListTile(
                    title: Text(
                      controller.studentModel.studentParentName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                    subtitle: Text(
                      controller.studentModel.studentCreate.toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                    trailing: Text(
                      controller.studentModel.studentParentPhone.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    color: Get.theme.primaryColor.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(controller.studentModel.studentBornDate
                              .toString()),
                          Text(controller.studentModel.studentType.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
