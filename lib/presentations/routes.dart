import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/home_screen.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen()
};
