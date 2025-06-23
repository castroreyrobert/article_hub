
import 'package:article_hub/features/article/presentation/pages/home_page.dart';
import 'package:article_hub/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/presentation/pages/signup_page.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
        case AppRoutes.signup:
          return MaterialPageRoute(builder: (_) => SignupPage());
      /*case AppRoutes.signup:
      // Example of passing arguments
        final arguments = settings.arguments as Map<String, dynamic>?;
        final userId = arguments?['userId'] as String?;
        return MaterialPageRoute(builder: (_) => ProfileScreen(userId: userId));*/
      default:
      // Optionally, handle unknown routes, e.g., show a 404 screen
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}