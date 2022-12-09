import 'package:get/get.dart';
import 'package:movieapp_test_sandi_romadon/bindings/dasboardbindings.dart';
import 'package:movieapp_test_sandi_romadon/screen/dashboard.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const DashoboardScreen(),
      binding: DashboardB(),
    ),
  ];
}
