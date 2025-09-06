import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning Văn',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
    );
  }
}
