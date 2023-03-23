import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/login_screen.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName:(context) => LoginScreen(),
};
