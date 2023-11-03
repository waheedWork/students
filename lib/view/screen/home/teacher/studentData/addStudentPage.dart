import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentsController.dart';
import 'package:students/core/class/handelingview.dart';
import 'package:students/view/widget/auth/apptextfield.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentsController studentsController = Get.find();
    Widget studentCard(int index) {
      return InkWell(
        onTap: () {
          studentsController.addStudentToLesson(index);
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

    return GetBuilder<StudentsController>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              studentsController.toRegisterStudent();
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: controller.isSearch
                ? AppTextField(
                    type: 'search',
                    auto: true,
                    iconData: Icons.search,
                    inputType: TextInputType.text,
                    onChanged: (p0) {
                      controller.update();
                    },
                    validator: (p0) {},
                    textFieldController: controller.searchController,
                  )
                : const Text('students').tr(),
            actions: [
              controller.isSearch
                  ? IconButton(
                      onPressed: () {
                        controller.closeSearch();
                      },
                      icon: const Icon(Icons.highlight_remove_outlined),
                    )
                  : IconButton(
                      onPressed: () {
                        studentsController.changeSearchMode();
                      },
                      icon: const Icon(Icons.search),
                    ),
            ],
          ),
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
                  child: HandelingRequest(
                    statusRequest: controller.statusRequest!,
                    widget: controller.studentsList.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.studentsList.length,
                            itemBuilder: (context, index) {
                              if (controller.isSearch) {
                                if (controller.studentsList[index].studentName
                                    .toString().removeAllWhitespace
                                    .isCaseInsensitiveContainsAny(
                                        controller.searchController.text.removeAllWhitespace)) {
                                  return studentCard(index);
                                } else {
                                  return Container();
                                }
                              } else {
                                return studentCard(index);
                              }
                            },
                          )
                        : const Text('no_students').tr(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
