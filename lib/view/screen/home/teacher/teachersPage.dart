import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allTeachersController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AllTeachersController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('teachersPage').tr(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addTeacherPage);
        },
        child: Icon(
          Icons.add,
          color: Get.theme.primaryColor,
        ),
      ),
      body: Center(
        child: GetBuilder<AllTeachersController>(
          builder: (allTeachersController) => allTeachersController
                      .statusRequest ==
                  StatusRequest.loading
              ? const CircularProgressIndicator()
              : allTeachersController.teachersModelList.isEmpty
                  ? const Text('no_teachers').tr()
                  : ListView.builder(
                      itemCount: allTeachersController.teachersModelList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            allTeachersController
                                .teachersModelList[index].teacherName
                                .toString(),
                            style: TextStyle(
                              color: Get.theme.backgroundColor,
                            ),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: tr('delete'),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          Get.back();
                                          await allTeachersController
                                              .deleteTeacher(
                                            allTeachersController
                                                .teachersModelList[index]
                                                .teacherId
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
                            icon:
                                Icon(Icons.close, color: Get.theme.canvasColor),
                          ),
                          trailing: Text(
                            allTeachersController
                                .teachersModelList[index].teacherPhone
                                .toString(),
                            style: TextStyle(
                              color: Get.theme.backgroundColor,
                            ),
                          ),
                          subtitle: Text(
                            allTeachersController
                                .teachersModelList[index].subjectName
                                .toString(),
                            style: TextStyle(
                              color: Get.theme.backgroundColor.withOpacity(0.5),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
