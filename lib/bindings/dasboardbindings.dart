import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/controller/dashboardcontroller.dart';

class DashboardB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
