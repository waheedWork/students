import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/friendsController.dart';
import 'package:students/core/class/handelingview.dart';

class FriendsTestsPage extends StatelessWidget {
  const FriendsTestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('exam_friends').tr()),
      body: Center(
        child: GetBuilder<FriendsController>(
          builder: (controller) {
            return HandelingView(
              statusRequest: controller.statusRequest!,
              widget: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Get.theme.primaryColor.withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${tr('avg')} : ${(controller.testsSum / controller.friendsTestsList.length).toStringAsFixed(1)} / ${controller.passedStudentSubjectModel.subjectMark}',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.friendsTestsList.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(controller.friendsTestsList[index].stdLesDate.toString()),

                          const Divider(),
                          ListTile(
                            title: Row(
                              children: [
                                controller.friendsTestsList.length == index + 1
                                    ? const Text(
                                        'maxMark',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.green,
                                        ),
                                      ).tr()
                                    : index == 0
                                        ? const Text(
                                            'minMark',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.redAccent,
                                            ),
                                          ).tr()
                                        : Container(),
                                SizedBox(
                                  width: Get.width / 22,
                                ),
                                Text(
                                  controller.friendsTestsList[index].studentId
                                              .toString() ==
                                          controller.passedStudentSubjectModel
                                              .studentId
                                              .toString()
                                      ? controller
                                          .friendsTestsList[index].studentName
                                          .toString()
                                      : '',
                                ),
                              ],
                            ),
                            trailing: Text(
                              controller.friendsTestsList[index].test
                                  .toString(),
                            ),
                          ),
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
