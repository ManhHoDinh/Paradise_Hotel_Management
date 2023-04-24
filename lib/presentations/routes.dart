import 'package:flutter/material.dart';
import 'package:paradise/presentations/screens/Bookings/rental_form.dart';
import 'package:paradise/presentations/screens/Onboardings/home_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/login_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/splash_screen.dart';
import 'package:paradise/presentations/screens/RoomKinds/AddRoomKindScreen.dart';
import 'package:paradise/presentations/screens/RoomKinds/RoomKindView.dart';
import 'package:paradise/presentations/screens/Rooms/seeAll_screen.dart';
import 'package:paradise/presentations/screens/createRoom_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  CreateRoomScreen.routeName: (context) => CreateRoomScreen(),
  RoomKindView.routeName: (context) => RoomKindView(),
  SeeAllScreen.routeName: (context) => SeeAllScreen(),
  AddRoomKindScreen.routeName: (context) => AddRoomKindScreen(),
  RentalForm.routeName: (context) => RentalForm(),
};
