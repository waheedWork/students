import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/view/widget/auth/apploginbutton.dart';

class UserTypePage extends StatelessWidget {
  const UserTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('user_type').tr()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSignUpAndLoginButton(
              text: tr('student'),
              onPressed: () {
                Get.toNamed(AppRoute.loginStudent);
              },
            ),
            AppSignUpAndLoginButton(
              text: tr('teacher'),
              onPressed: () {
                Get.toNamed(AppRoute.loginTeacher);
              },
            ),
            // AppSignUpAndLoginButton(
            //   text: tr('change_lang'),
            //   onPressed: () async {
            //     if (context.locale == const Locale('ar', 'DZ')) {
            //       context.locale = const Locale('en', 'US');
            //     } else {
            //       context.locale = const Locale('ar', 'DZ');
            //     }
            //     Get.updateLocale(context.locale);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
