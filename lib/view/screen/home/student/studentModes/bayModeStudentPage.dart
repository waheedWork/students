import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdBayController.dart';

import '../../../../../core/class/handelingview.dart';

class BayModeStudentPage extends StatelessWidget {
  const BayModeStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StdBayController controller = Get.find();
    bayDoneWidget() {
      return controller.sum >=
              double.parse(
                controller.bayModelList.first.studentBay.toString(),
              )
          ? const Text(
              'bayDone',
              style: TextStyle(
                color: Colors.green,
                fontSize: 33,
              ),
            ).tr()
          : Text(
              '${tr('remain')}  :  ${double.parse(
                    controller.bayModelList.first.studentBay.toString(),
                  ) - controller.sum}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            );
    }

    sumWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${tr('sum')}  :  ${controller.sum.toString()} / ${controller.bayModelList.first.studentBay}',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    bayDataWidgetList() {
      return ListView.builder(
        itemCount: controller.bayModelList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              controller.bayModelList[index].quantity
                  .toString(),
            ),
            trailing: Text(
              controller.bayModelList[index].bayDate
                  .toString(),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('bay').tr()),
      body: Center(
        child: GetBuilder<StdBayController>(
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
