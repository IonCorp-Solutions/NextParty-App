import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_party_application/content/menu/home.dart';
import 'package:next_party_application/content/menu/profile.dart';
import 'package:next_party_application/content/menu/settings.dart';
import 'package:next_party_application/theme/theme.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    Home(),
    Profile(),
    Settings(),
  ];
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gift_fill),
            label: 'Home',
            backgroundColor: AppTheme.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle_fill),
            label: 'Profile',
            backgroundColor: AppTheme.whiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: AppTheme.whiteColor,
          ),
        ],
        backgroundColor: AppTheme.whiteColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.greyColor,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'NEXTPARTY',
          style: AppTheme.head,
        ),
      ),
      body: _pages.elementAt(selectedIndex),
    );
  }
}
