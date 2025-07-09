import 'package:article_hub/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'core/utils/dependency_injector.dart';


Future<void> main() async {
  await setUpDependencyInjector();
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'GeneralSans',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          chipTheme: ChipThemeData(
            selectedColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))

          )
        ),
       onGenerateRoute: AppRoutes.onGenerateRoute,
      )
  );
}

