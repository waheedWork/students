import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/core/class/handelingview.dart';

class AllStudentsBayPage extends StatelessWidget {
  const AllStudentsBayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllStudentsBayController studentsController = Get.find();
    Widget studentCard(int index) {
      return InkWell(
        onTap: () {
          studentsController.toBayStudentPage(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            color: Get.theme.primaryColor.withOpacity(0.2),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width / 3.2,
                    child: Text(
                      studentsController.studentsList[index].studentName
                          .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3.5,
                    child: Text(
                      studentsController.studentsList[index].studentParentName
                          .toString(),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3.1,
                    child: Text(
                      studentsController.studentsList[index].studentPhone
                          .toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('bay').tr()),
      body: Center(
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('student').tr(),
                const Text('parent').tr(),
                const Text('phone').tr(),
              ],
            ),
            Expanded(
              child: GetBuilder<AllStudentsBayController>(
                builder: (controller) => HandelingRequest(
                  statusRequest: controller.statusRequest!,
                  widget: controller.studentsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.studentsList.length,
                          itemBuilder: (context, index) {
                            return studentCard(index);
                          },
                        )
                      : const Text('no_students').tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
