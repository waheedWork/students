import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/constant/peroidTime.dart';
import 'package:students/core/function/getDate.dart';

import '../../../../../controller/auth_controllers/student/stdTestsController.dart';
import '../../../../../core/class/handelingview.dart';

class ComeModeStudentPage extends StatelessWidget {
  const ComeModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdTestsComeController controller = Get.find();

    comeWidget(int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor:
              controller.comeList[index] ? null : Colors.red.withOpacity(0.2),
          shape: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Get.theme.primaryColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width / 3,
                child: controller.comeList[index]
                    ? controller.studentALLSubjectsList[index].late
                                .toString() ==
                            ''
                        ? const Icon(
                            Icons.done_outline_rounded,
                            color: Colors.greenAccent,
                          )
                        : Row(
                            children: [
                              const Text('late').tr(),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                controller.studentALLSubjectsList[index].late
                                    .toString(),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('minute').tr(),
                            ],
                          )
                    : const Text(
                        'isNotCome',
                        style: TextStyle(fontSize: 18),
                      ).tr(),
              ),
              SizedBox(
                width: Get.width / 7,
                child: Column(
                  children: [
                    Text(
                      controller.studentALLSubjectsList[index].lessonDay
                          .toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                    Text(
                      controller.studentALLSubjectsList[index].lessonTime
                          .toString(),
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width / 7,
                child: Text(
                  AppFunctions.getDate(
                    controller.studentALLSubjectsList[index].stdLesDate
                        .toString(),
                  ),
                  style: const TextStyle(fontSize: 8),
                ),
              ),
            ],
          ),
          // subtitle:
          //     : ,
          trailing: SizedBox(
            width: Get.width / 6,
            child: Text(
              controller.studentALLSubjectsList[index].subjectName.toString(),
            ),
          ),
        ),
      );
    }

    return GetBuilder<StdTestsComeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text('isCome').tr(),
                Expanded(child: Container()),
              ],
            ),
          ),
          body: Center(
            child: HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.studentALLSubjectsList.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          color: Get.theme.scaffoldBackgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${tr('isNotCome')} ${controller.comeCount} / ',
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: tr('periodTime'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(
                                        periodTimeList.length,
                                        (index) => InkWell(
                                          onTap: () {
                                            controller.setPeriodTime(
                                              periodTimeList[index],
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(periodTimeList[index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.periodTime,
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.comeList.length,
                            itemBuilder: (context, index) {
                              if (controller.periodTime ==
                                  periodTimeList.first) {
                                return comeWidget(index);
                              } else if (controller.periodTime ==
                                  periodTimeList.last) {
                                if (DateTime.now()
                                        .difference(
                                          DateTime.parse(
                                            controller
                                                .studentALLSubjectsList[index]
                                                .stdLesDate
                                                .toString(),
                                          ),
                                        )
                                        .inDays <=
                                    7) {
                                  return comeWidget(index);
                                } else {
                                  return Container();
                                }
                              } else {
                                if (DateTime.now()
                                        .difference(
                                          DateTime.parse(
                                            controller
                                                .studentALLSubjectsList[index]
                                                .stdLesDate
                                                .toString(),
                                          ),
                                        )
                                        .inDays <=
                                    31) {
                                  return comeWidget(index);
                                } else {
                                  return Container();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text('no_dates').tr(),
            ),
          ),
        );
      },
    );
  }
}
