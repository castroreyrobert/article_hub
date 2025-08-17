import 'package:article_hub/core/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'core/configs/flavor_config.dart';
import 'core/utils/dependency_injector.dart';


Future<void> mainCommon({required Flavor flavor, required String baseUrl, required String name}) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(flavor: flavor, baseUrl: baseUrl, name: name);
  await setUpDependencyInjector();
  await dependencyInjector.allReady();
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

