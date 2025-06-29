
import 'package:article_hub/ui/account_page.dart';
import 'package:article_hub/ui/authentication/pages/login_page.dart';
import 'package:article_hub/ui/authentication/pages/signup_page.dart';
import 'package:article_hub/ui/cart_page.dart';
import 'package:article_hub/ui/products/pages/discover_page.dart';
import 'package:article_hub/ui/products/pages/search_page.dart';
import 'package:article_hub/ui/saved_page.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String saved = '/saved';
  static const String search = '/search';
  static const String account = '/account';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => DiscoverPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => CartPage());
      case AppRoutes.saved:
        return MaterialPageRoute(builder: (_) => SavedPage());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => SearchPage());
      case AppRoutes.account:
        return MaterialPageRoute(builder: (_) => AccountPage());
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