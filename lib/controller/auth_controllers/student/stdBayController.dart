import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../core/class/statusrequest.dart';
import '../../../core/function/handlingdata.dart';
import '../../../core/services/services.dart';
import '../../../data/datasource/remote/student/getStudent.dart';
import '../../../data/model/bayModel.dart';

class StdBayController extends GetxController {
  List<BayModel> bayModelList = [];
  MyServices myServices = Get.find();
  StudentData studentData = StudentData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  late String studentModelId;

  @override
  void onInit() {
    super.onInit();
  }

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
          List list = response['data'];
          for (var element in list) {
            bayModelList.add(BayModel.fromJson(element));
          }
          getSum();
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
  }
}