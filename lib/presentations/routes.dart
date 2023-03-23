import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/AddUser_screen.dart';
import 'package:paradise/presentations/screens/UserViewer.dart';
import 'package:paradise/presentations/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  AddUserScreen.routeName: (context) => AddUserScreen(),
  UserViewScreen.routeName: (context) => UserViewScreen(),
};
