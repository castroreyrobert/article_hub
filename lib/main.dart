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
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
        },
      )
  );
}

