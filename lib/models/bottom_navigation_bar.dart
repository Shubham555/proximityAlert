import 'package:covidScanner/screens/history_screen.dart';
import 'package:covidScanner/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:covidScanner/themes/constants.dart';
import 'package:covidScanner/screens/home_screen.dart';

class MyBottomNavBar extends StatefulWidget {
  static const routeName = "/BottomNavBar";
  MyBottomNavBar({Key key}) : super(key: key);

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    HistoryScreen(),
    HomeScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: kPrimaryColor,
            unselectedIconTheme: IconThemeData(opacity: 0.7),
            unselectedItemColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('History'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
                title: Text(
                  '',
                  strutStyle: StrutStyle(height: 0),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedIconTheme: IconThemeData(
              size: 26,
              opacity: 1,
            ),
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
