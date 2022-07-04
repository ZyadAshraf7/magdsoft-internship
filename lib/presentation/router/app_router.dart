import 'package:flutter/material.dart';
import '../screens/user/login_screen.dart';
import '../screens/user/register_screen.dart';
import '../screens/user/user_profile.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/userProfile':
        return MaterialPageRoute(builder: (_) => const UserProfile());
      default:
        return null;
    }
  }
}
