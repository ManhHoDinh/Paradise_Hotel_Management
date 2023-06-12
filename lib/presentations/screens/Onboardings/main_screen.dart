import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paradise/presentations/screens/Onboardings/Account.dart';
import 'package:paradise/presentations/screens/Onboardings/notification_screen.dart';
import 'package:paradise/presentations/screens/Onboardings/setting_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../core/helpers/AuthFunctions.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String routeName = 'main_screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    AuthServices.UpdateCurrentUser();
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          SettingScreen(),
          NotificationScreen(),
          AccountScreen(),
        ],
      ),
      // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (id) {
            setState(() {
              _currentIndex = id;
            });
          },
          items: [
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.house,
                  size: 20,
                ),
                title: Text('Home')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.gear,
                  size: 20,
                ),
                title: Text('Setting')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  size: 20,
                ),
                title: Text('Notification')),
            SalomonBottomBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: 20,
                ),
                title: Text('Account')),
          ]),
    );
  }
}
