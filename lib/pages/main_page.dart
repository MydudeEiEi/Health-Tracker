import 'package:flutter/material.dart';
import 'package:health_tracker/pages/home_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final int _fadeDuration = 150;
  final double _iconBackgroundPadding = 11.5;

  final List<Widget> _pages = const [
    Text('Dish'),
    HomePage(),
    Text('Gym'),
  ];

  void _onTapNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: _currentIndex == 0
                        ? MyColors.redOrange
                        : MyColors.transparent,
                    shape: BoxShape.circle),
                duration: Duration(milliseconds: _fadeDuration),
                child: Padding(
                  padding: EdgeInsets.all(_iconBackgroundPadding),
                  child: buildIcon('dish'),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: _currentIndex == 1
                        ? MyColors.redOrange
                        : MyColors.transparent,
                    shape: BoxShape.circle),
                duration: Duration(milliseconds: _fadeDuration),
                child: Padding(
                  padding: EdgeInsets.all(_iconBackgroundPadding),
                  child: buildIcon('home'),
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: _currentIndex == 2
                        ? MyColors.redOrange
                        : MyColors.transparent,
                    shape: BoxShape.circle),
                duration: Duration(milliseconds: _fadeDuration),
                child: Padding(
                  padding: EdgeInsets.all(_iconBackgroundPadding),
                  child: buildIcon('dumbbell'),
                ),
              ),
              label: ''),
        ],
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: _onTapNavigationBar,
        elevation: 30,
      ),
    );
  }
}
