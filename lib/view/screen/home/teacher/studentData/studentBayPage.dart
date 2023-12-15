import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/allStudentsBayController.dart';
import 'package:students/controller/auth_controllers/teacher/studentDataController.dart';
import 'package:students/controller/auth_controllers/teacher/teacherController.dart';
import 'package:students/core/class/handelingview.dart';


class StudentBayPage extends StatelessWidget {
  const StudentBayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllStudentsBayController allStudentsBayController =
        Get.put(AllStudentsBayController());
    StudentDataController controller = Get.find();
    TeacherController teacherController = Get.find();
    bayDoneWidget() {
      return controller.sum >=
              double.parse(
                controller.bayModelList.first.studentBay.toString(),
              )
          ? const Text(
              'bayDone',
              style: TextStyle(
                color: Colors.green,fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ).tr()
          : Text(
              '${tr('remain')}  :  ${double.parse(
                    controller.bayModelList.first.studentBay.toString(),
                  ) - controller.sum}',
              style: const TextStyle(
                color: Colors.red,fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            );
    }

    sumWidget() {
      return SingleChildScrollView(

       scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${tr('sum')}  :  ${controller.sum.toStringAsFixed(0)} / ${controller.bayModelList.first.studentBay}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    bayDataWidgetList() {
      return ListView.builder(
        itemCount: controller.bayModelList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
              print(controller.bayModelList[index].bayId.toString());
              Get.defaultDialog(
                  title: tr('delete'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await
                          allStudentsBayController.deleteBay(
                              controller.bayModelList[index].bayId.toString()
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
            child: ListTile(
              title: Text(
                controller.bayModelList[index].quantity.toString(),
              ),
              trailing: Text(
                controller.bayModelList[index].bayDate.toString(),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: teacherController.teacherModel.teacherId != '9'
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                allStudentsBayController.addStudentBay(context);
                print(allStudentsBayController.studentId.toString());
              },
              child: const Icon(Icons.add),
            ),
      appBar: AppBar(
        title: const Text('bay').tr(),

          actions: [

            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: controller.copy));
              },
              icon: const Icon(Icons.copy),
            ),
            IconButton(
              onPressed: () {
                if(teacherController.teacherModel.teacherId=='9'){
                  controller.toEditeStudent();

                }else{
                  Get.snackbar('خطأ', 'فقط المشرف');
                }
              },
              icon: Icon(
                Icons.edit,
                color: Get.theme.primaryColor,
              ),
            )
          ],
      ),
      body: Center(
        child: GetBuilder<StudentDataController>(
          builder: (controller) {
            return HandelingRequest(
              statusRequest: controller.statusRequest!,
              widget: controller.bayModelList.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: sumWidget(),
                        ),
                        bayDoneWidget(),
                        Expanded(
                          flex: 10,
                          child: bayDataWidgetList(),
                        ),
                      ],
                    )
                  : const Text('no_bay').tr(),
            );
          },
        ),
      ),
    );
  }
}
