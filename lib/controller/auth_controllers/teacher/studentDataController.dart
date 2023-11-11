import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:students/controller/auth_controllers/teacher/studentsController.dart';
import 'package:students/core/class/statusrequest.dart';
import 'package:students/core/constant/approutes.dart';
import 'package:students/data/datasource/remote/student/getStudent.dart';
import 'package:students/data/model/bayModel.dart';
import 'package:students/data/model/student_model.dart';

import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';

class StudentDataController extends GetxController {
  StudentModel studentModel = StudentModel();
  List<BayModel> bayModelList = [];
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  late String studentModelId;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  getStudentData(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    studentModelId = id;
    bayModelList.clear();
    try {
      var response =
          await studentData.getStudentData(studentId: studentModelId);
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          studentModel = StudentModel.fromJson(response['data']);
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('getTeacherLessons catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  String copy = '';

  Future<void> getStudentBay(String studentId) async {
    statusRequest = StatusRequest.loading;
    update();
    studentModelId = studentId;
    bayModelList.clear();
    try {
      var response = await studentData.getStudentBay(studentId: studentModelId);
      statusRequest = handlingData(response);
      print(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          copy = '';
          List list = response['data'];
          for (var element in list) {
            bayModelList.add(BayModel.fromJson(element));
            addCopies();
          }
          getSum();
          copy += '\n' + tr('sum') +
              ' : ' +
              sum.toString() +
              '\n';
          copy += '\n' + tr('studentBay') +
              ' : ' +
              "${double.parse(bayModelList.first.studentBay.toString())}" +
              '\n';
          copy += '\n' + tr('remain') +
              ' : ' +
              "${double.parse(bayModelList.first.studentBay.toString())-sum}" +
              '\n';
        }
      } else {
        Get.snackbar(tr('connectionError'), "");
      }
    } catch (e) {
      print('getStudentBay catch $e');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  double sum = 0;

  void getSum() {
    sum = 0;
    if (bayModelList.isNotEmpty) {
      for (var element in bayModelList) {
        sum += double.parse(element.quantity.toString());
      }
    }

    update();
  }

  void toEditeStudent() async {
    StudentsController studentsController = Get.put(StudentsController());

    studentsController.toRegisterStudent('update');
    await getStudentData(studentModelId);
    studentsController.setValues(studentModel);
    // Get.to(AppRoute.registerPage);
  }

  void addCopies() {
    copy += '\n' + tr('bay_number') + bayModelList.length.toString() + '\n';
    copy += tr('quantity') +
        ' : ' +
        bayModelList.last.quantity.toString() +
        '\n';
    copy += tr('date') +
        ' : ' +
        bayModelList.last.bayDate.toString() +
        '\n';
  }
}
