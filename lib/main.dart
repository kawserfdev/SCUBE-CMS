import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const ScubeTaskApp());
}

class ScubeTaskApp extends StatelessWidget {
  const ScubeTaskApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Scube CMS Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
    );
  }
}
