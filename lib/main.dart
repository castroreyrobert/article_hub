import 'package:article_hub/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/dependency_injector.dart';
import 'features/authentication/presentation/pages/login_page.dart';


Future<void> main() async {
  await setUpDependencyInjector();
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'PlusJakartaSans'
        ),
       onGenerateRoute: AppRoutes.onGenerateRoute,
      )
  );
}

