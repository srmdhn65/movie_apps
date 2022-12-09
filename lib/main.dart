import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movieapp_test_sandi_romadon/routes/app_pages.dart';
import 'package:movieapp_test_sandi_romadon/routes/app_routes.dart';
import 'package:movieapp_test_sandi_romadon/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Apps',
      getPages: AppPages.list,
      // home: const KetentuanUmumScreen(),
      theme: ThemeData(
        primaryColor: Style.primaryColor,
      ),
      initialRoute: AppRoutes.initial,
    );
  }
}
