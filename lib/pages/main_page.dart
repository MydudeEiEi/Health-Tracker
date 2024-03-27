import 'package:flutter/material.dart';
import 'package:health_tracker/components/profile_img.dart';
import 'package:health_tracker/components/water_drop_button.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/pages/food_page.dart';
import 'package:health_tracker/pages/gym_page.dart';
import 'package:health_tracker/pages/home_page.dart';
import 'package:health_tracker/pages/profile_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  final int indexPage;
  const MainPage({super.key, this.indexPage = 1});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  DateTime _selectedDate = DateTime.now();
  final int _fadeDuration = 150;
  final double _iconBackgroundPadding = 11.5;
  List<Widget> pages = [];

  _MainPageState() {
    pages = [
      const FoodPage(),
      HomePage(_selectedDate),
      const GymPage(),
    ];
  }

  void _onTapNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _onTapCalendar() async {
    final DateTime? selectedDate = await showMyDatePicker();
    setState(() {
      _selectedDate = selectedDate ?? _selectedDate;
      pages[1] = const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
      pages[1] = HomePage(_selectedDate);
    });
  }

  @override
  void initState() {
    _currentIndex = widget.indexPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double topScreenMargin = MediaQuery.of(context).viewPadding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * .025),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: topScreenMargin + 10, bottom: topScreenMargin * .25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileImg(ProfilePage()),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${UserController.user?.displayName?.split(' ')[0] ?? 'Guest'}!",
                        style: MyTextStyle.subtitle(),
                      ),
                      Text(
                        DateFormat('EEEE, d MMMM').format(DateTime.now()),
                        style: MyTextStyle.title(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const WaterDropButton(),
                  SizedBox(width: screenWidth * .025),
                  Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      //This keeps the splash effect within the circle
                      borderRadius: BorderRadius.circular(
                          25.0), //Something large to ensure a circle
                      onTap: _onTapCalendar,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          size: 26,
                          color: MyColors.redCalendar,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: pages.elementAt(_currentIndex),
            ),
          ],
        ),
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

  Future<DateTime?> showMyDatePicker() async {
    return await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: _selectedDate,
        builder: (context, child) => Theme(
            data: ThemeData.light().copyWith(
              primaryColor: const Color.fromARGB(255, 93, 144, 255),
              colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 93, 144, 255)),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!));
  }
}
