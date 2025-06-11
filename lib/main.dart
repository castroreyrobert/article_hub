import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/login/login_page.dart';


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

