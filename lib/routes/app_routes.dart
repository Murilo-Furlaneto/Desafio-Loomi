import 'package:desafio_loomi/ui/features/authentication/views/screens/login_screen.dart';
import 'package:desafio_loomi/ui/features/authentication/views/screens/sign_up_screen.dart';
import 'package:desafio_loomi/ui/features/home/views/screens/home_screen.dart';
import 'package:desafio_loomi/ui/features/profile/views/screens/profile_screen.dart';
import 'package:desafio_loomi/ui/features/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String splash = '/splash';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    signup: (context) => SignUpScreen(),
    profile: (context) => ProfileScreen(),
    splash: (context) => SplashScreen(),
  };
}