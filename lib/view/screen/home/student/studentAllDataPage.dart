import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/constant/days.dart';
import 'package:students/core/function/getDate.dart';
import '../../../../controller/auth_controllers/student/stdTestsController.dart';

class StudentAllDataPage extends StatelessWidget {
  const StudentAllDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('comeProgram').tr()),
      body: Center(
        child: GetBuilder<StdTestsComeController>(
          builder: (controller) => ListView.builder(
            itemCount: controller.datesList.length,
            itemBuilder: (context, index) {
              bool isToday = false;
              if (DateFormat('EEEE').format(DateTime.now())==
                  controller.datesList[index].lessonDay) {
                isToday = true;
              }
              return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isToday
                        ? Get.theme.primaryColor.withOpacity(0.5)
                        : Get.theme.backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            controller.datesList[index].subjectName.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            controller.datesList[index].lessonDay.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            controller.datesList[index].lessonTime.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            controller.datesList[index].teacherName.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
