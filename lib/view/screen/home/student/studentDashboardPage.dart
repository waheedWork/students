import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/student/stdTestsController.dart';
import 'package:students/controller/auth_controllers/student/studentDashboardController.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentDashboardController studentDashboardController =
        Get.put(StudentDashboardController());

    gardCardWidget({required Null Function() onTap, required String text}) {
      return InkWell(
        onTap: onTap,
        child: Card(
          color: Get.theme.scaffoldBackgroundColor,
          shape: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(11),
            ),
            borderSide: BorderSide(
              color: Get.theme.primaryColor,width: 0.4
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Get.theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ).tr(),
          ),
        ),
      );
    }

    gradViewWidget() {
      return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          gardCardWidget(
            onTap: () {
              studentDashboardController.toStudentBayPage();
            },
            text: 'bay',
          ),
          gardCardWidget(
            onTap: () {
              studentDashboardController.toStudentSubjectsTestsPage();
            },
            text: 'exams',
          ),
          gardCardWidget(
            onTap: () {
              studentDashboardController.toStudentSubjectsComesPage();
            },
            text: 'isCome',
          ),
          gardCardWidget(
            onTap: () {
              studentDashboardController.toStudentSubjectsNotesPage();
            },
            text: 'notes',
          ),
        ],
      );
    }

    customDrawerButton({required Null Function() onTap, required String text}) {
      return InkWell(
        onTap: onTap,
        child: Card(

          color: Get.theme.scaffoldBackgroundColor.withAlpha(111),
          // shape: OutlineInputBorder(
          //   borderRadius: const BorderRadius.all(
          //     Radius.circular(12),
          //   ),
          //   borderSide: BorderSide(
          //     color: Get.theme.primaryColor,width: 0
          //   ),
          // ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ).tr(),
            ),
          ),
        ),
      );
    }

    refreshWidget() {
      return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(33)),
            color: Get.theme.scaffoldBackgroundColor),
        child: IconButton(
          onPressed: () async {
            StdTestsComeController controller =
                Get.put(StdTestsComeController());
            await controller.getStudentSubjects(controller.studentModelId);
          },
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.refresh,
              color: Get.theme.primaryColor,
            ),
          ),
        ),
      );
    }

    allDataWidget() {
      return SizedBox(
        height: Get.height / 10,
        child: InkWell(
          onTap: () {
            studentDashboardController.toStudentAllDataPage();
          },
          child: Card(
            color: Get.theme.scaffoldBackgroundColor,
            shape: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(11),
              ),
              borderSide: BorderSide(
                color: Get.theme.scaffoldBackgroundColor,
                width: 0.5,
              ),
            ),
            child: Center(
              child: Text(
                'comeProgram',
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ).tr(),
            ),
          ),
        ),
      );
    }

    drawerWidget() {
      return SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                width: Get.width / 5,
                height: Get.width / 5,
                decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor.withAlpha(111),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        studentDashboardController.studentModel.studentName
                            .toString(),
                        style:  const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        studentDashboardController.studentModel.studentPhone
                            .toString(),
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,color: Get.theme.primaryColor
                        ),
                      ),
                      Text(
                        studentDashboardController.studentModel.studentCreate
                            .toString(),
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            customDrawerButton(
              onTap: () {
                studentDashboardController.toStudentBayPage();
              },
              text: 'bay',
            ),
            customDrawerButton(
              onTap: () {
                studentDashboardController.toStudentSubjectsTestsPage();
              },
              text: 'exams',
            ),
            customDrawerButton(
              onTap: () {
                studentDashboardController.toStudentSubjectsComesPage();
              },
              text: 'isCome',
            ),
            customDrawerButton(
              onTap: () {
                studentDashboardController.toStudentSubjectsNotesPage();
              },
              text: 'notes',
            ),
            // Expanded(child: Container()),
            customDrawerButton(
              onTap: () {
                studentDashboardController.logout();
              },
              text: 'logout',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      endDrawer: Drawer(
        child: drawerWidget(),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('student').tr(),
            Expanded(child: Container()),
            Text(
              studentDashboardController.studentModel.studentName.toString(),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Get.theme.scaffoldBackgroundColor,
              Get.theme.scaffoldBackgroundColor,
              Get.theme.primaryColor,
            ],
            stops: const [0.1, 0.1, 0.7],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: Get.height / 24,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: gradViewWidget(),
              ),
              allDataWidget(),
              Expanded(
                child: Container(),
              ),
              refreshWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
