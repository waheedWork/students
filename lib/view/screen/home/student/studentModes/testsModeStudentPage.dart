import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdTestsController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/function/getDate.dart';

class TestsModeStudentPage extends StatelessWidget {
  const TestsModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdTestsComeController controller = Get.find();

    Widget testWidget(int index) {
      return InkWell(
        onTap: () {
          print(controller.testsList[index].subjectName);
          controller.toFriendsTestsPage(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppFunctions.getDate(
                      controller.testsList[index].stdLesDate.toString(),
                    ),
                    style: const TextStyle(fontSize: 9),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.testsList[index].lessonDay.toString(),
                    style: const TextStyle(fontSize: 9),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.testsList[index].lessonTime.toString(),
                    style: const TextStyle(fontSize: 9),
                  ),
                  SizedBox(
                    width: Get.width / 4,
                  ),
                  InkWell(
                    onTap: () {
                      controller.toFriendsTestsPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        'exam_friends',
                        style: TextStyle(fontSize: 8, color: Colors.blue),
                      ).tr(),
                    ),
                  ),
                ],
              ),
              ListTile(
                shape: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Get.theme.primaryColor),
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: Get.width / 5,
                      child: Text(
                        controller.testsList[index].subjectName.toString(),
                      ),
                    ),
                    Text(
                      controller.testsList[index].teacherName.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  controller.testsList[index].studentLessonNote.toString(),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  width: Get.width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        double.parse(
                          controller.testsList[index].test.toString(),
                        ).toStringAsFixed(0),
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontSize: 18,
                        ),
                      ),
                      const Text('/'),
                      Text(
                        controller.testsList[index].subjectMark.toString(),
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    subjectsListWidget() {
      return Container(
        color: Get.theme.scaffoldBackgroundColor,
        height: Get.height / 12,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.testsSubjectsNameList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              controller.setSort(controller.testsSubjectsNameList[index]);
              print(controller.sort);
            },
            child: Card(
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Get.theme.primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              color: controller.sort == controller.testsSubjectsNameList[index]
                  ? Get.theme.primaryColor.withOpacity(0.5)
                  : Get.theme.scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.all(Get.width / 33),
                child: Center(
                  child: Text(
                    controller.testsSubjectsNameList[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    animationAvgWidget() {
      return AnimatedContainer(
        margin: const EdgeInsets.symmetric(vertical: 10),
        duration: const Duration(
          milliseconds: 200,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          color: Get.theme.primaryColor.withOpacity(0.3),
        ),
        height: controller.sort == '' ? 0 : Get.height / 14,
        width: controller.sort == '' ? 0 : Get.width / 1.5,
        child: Center(
          child: Text(
            controller.subjectCount != 0
                ? '${tr('avg')} : ${controller.subjectAvg.toStringAsFixed(1)}'
                : 'noExams',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ).tr(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('subjects').tr(),
      ),
      body: Center(
        child: GetBuilder<StdTestsComeController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.testsList.isNotEmpty
                  ? Column(
                      children: [
                        subjectsListWidget(),
                        animationAvgWidget(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.testsList.length,
                            itemBuilder: (context, index) {
                              if (controller.sort == '') {
                                return testWidget(index);
                              } else {
                                if (controller.testsList[index].subjectName ==
                                    controller.sort) {
                                  return testWidget(index);
                                } else {
                                  return Container();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text('noExams').tr(),
            );
          },
        ),
      ),
    );
  }
}
