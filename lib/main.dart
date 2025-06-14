import 'package:flutter/material.dart';
import 'features/authentication/presentation/pages/login_page.dart';


void main() {
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

