import 'package:article_hub/core/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'core/utils/dependency_injector.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpDependencyInjector();

  try {
    await dependencyInjector.allReady(); // WAITS FOR ASYNC SINGLETONS
    print("main: dependencyInjector.allReady() COMPLETED SUCCESSFULLY.");
  } catch (e, s) {
    print("main: dependencyInjector.allReady() FAILED: $e");
    print(s);
    // Handle critical failure
    return;
  }

  print("main: Running app...");
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'PlusJakartaSans',
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

