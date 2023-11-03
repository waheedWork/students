import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/load_controller.dart';
import 'package:students/core/constant/approutes.dart';

class LoadPage extends StatelessWidget {
  LoadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoadController loadController = Get.put(LoadController());
    print('========LoadPageLoadPageLoadPage=================');

    return Scaffold(
      appBar: AppBar(title: Text('${tr('wait')}...')),
      body: Center(
        child: GetBuilder<LoadController>(
          builder: (controller) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loadController.late > 0
                  ? const Text('connectionError').tr()
                  : CircularProgressIndicator(
                color: Get.theme.primaryColor,
              ),
              SizedBox(
                height: Get.height / 8,
              ),
              loadController.late > 0
                  ? IconButton(
                onPressed: () {
                  loadController.setLate(0);
                  Get.offAllNamed(AppRoute.load);
                },
                icon: Icon(Icons.refresh, color: Get.theme.primaryColor),
              )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
