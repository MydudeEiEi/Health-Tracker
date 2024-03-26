import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_tracker/controller/gym_controller.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/number.dart';
import 'package:health_tracker/utils/style.dart';

class GymPage extends StatefulWidget {
  const GymPage({Key? key}) : super(key: key);

  @override
  State<GymPage> createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  final GymController controller = GymController();

  final List<Map<String, String>> menuList = [
    {'title': 'Indoor Walk', 'icon': 'indoor_walk'},
    {'title': 'Outdoor Walk', 'icon': 'outdoor_walk'},
    {'title': 'Indoor Run', 'icon': 'indoor_run'},
    {'title': 'Outdoor Run', 'icon': 'outdoor_run'},
    {'title': 'COMING SOON', 'icon': ''}
  ];

  String kcalCalculator(String action, int seconds) {
    if (action.contains('Walk')) {
      const kcalPerSec = 0.075;
      setState(() {
        exerciseBurn = kcalPerSec * seconds;
      });
      return '${(kcalPerSec * seconds).floor()} Kcal';
    }
    const kcalPerSec = 0.145;
    setState(() {
      exerciseBurn = kcalPerSec * seconds;
    });
    return '${(kcalPerSec * seconds).floor()} Kcal';
  }

  int _currentIndex = 0;
  int _goTimerFrom = 0;

  int _timerSeconds = 0;

  Timer? timer;
  int exerciseTime = 0;
  num exerciseBurn = 0;
  Icon iconTimer = const Icon(
    Icons.play_arrow_outlined,
    size: 50,
    color: Colors.black,
  );

  void updateIcon() {
    setState(() {
      if (timer == null) {
        iconTimer = const Icon(
          Icons.pause_outlined,
          size: 50,
          color: Colors.black,
        );
      } else if (timer!.isActive) {
        iconTimer = const Icon(
          Icons.play_arrow_outlined,
          size: 50,
          color: Colors.black,
        );
      } else {
        iconTimer = const Icon(
          Icons.pause_outlined,
          size: 50,
          color: Colors.black,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.updateTodayBurnByUserId(UserController.user!.uid, exerciseBurn);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      menuPage(),
      setTimerPage(1),
      setTimerPage(2),
      setTimerPage(3),
      setTimerPage(4),
      timerPage(_goTimerFrom)
    ];

    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Activity", style: MyTextStyle.title()),
                ),
                Expanded(
                  child: pages.elementAt(_currentIndex),
                ),
              ])),
    );
  }

  Widget menuPage() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          final data = menuList[index];

          if (data['icon'] == "") {
            return SizedBox(
              width: double.infinity,
              height: 90,
              child: Card(
                  color: MyColors.activityCard,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * .025),
                    child: Center(
                      child: Text("COMING SOON",
                          style: MyTextStyle.title(color: Colors.white)),
                    ),
                  )),
            );
          }

          return Card(
              color: MyColors.activityCard,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 0,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index + 1;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * .025, vertical: 5),
                    child: ListTile(
                        title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildIcon(data['icon']!, size: 60, color: Colors.white),
                        Expanded(
                          child: Center(
                            child: Text(data['title']!,
                                style: MyTextStyle.title(color: Colors.white)),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ));
        });
  }

  Widget setTimerPage(int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    index = index - 1;
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * .025, vertical: 15),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.activityCard),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildIcon(menuList[index]['icon']!,
                          size: 80, color: Colors.white),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(menuList[index]['title']!,
                              style: MyTextStyle.title(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: screenWidth * .025,
                        ),
                        Ink(
                          child: GestureDetector(
                            onTap: () => {
                              setState(() {
                                _timerSeconds -= 60;
                                if (_timerSeconds < 0) _timerSeconds = 0;
                              })
                            },
                            onLongPress: () => {
                              timer = Timer.periodic(
                                  const Duration(milliseconds: 50), (timer) {
                                setState(() {
                                  _timerSeconds -= 60;
                                  if (_timerSeconds < 0) _timerSeconds = 0;
                                });
                              })
                            },
                            onLongPressEnd: (_) {
                              timer?.cancel();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: MyColors.wrong,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text('-',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          durationToString(_timerSeconds),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Spacer(),
                        Ink(
                          child: GestureDetector(
                            onTap: () => {
                              setState(() {
                                _timerSeconds += 60;
                              })
                            },
                            onLongPress: () => {
                              timer = Timer.periodic(
                                  const Duration(milliseconds: 50), (timer) {
                                setState(() {
                                  _timerSeconds += 60;
                                });
                              })
                            },
                            onLongPressEnd: (_) {
                              timer?.cancel();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: MyColors.correct,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text('+',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * .025,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.fatCard,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        setState(() {
                          _currentIndex = menuList.length;
                          _goTimerFrom = index;
                        });
                      },
                      child: const Text('Start',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            )));
  }

  Widget timerPage(int index) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final setTime = _timerSeconds;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * .025, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.activityCard),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildIcon(menuList[index]['icon']!,
                          size: 80, color: Colors.white),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(menuList[index]['title']!,
                              style: MyTextStyle.title(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildIcon('stopwatch', size: 60),
                              const Text("TIME",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(durationToString(_timerSeconds),
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              backgroundColor: MyColors.wrong,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () {
                            if (timer != null && timer!.isActive) {
                              updateIcon();
                              timer?.cancel();
                            } else {
                              updateIcon();
                              timer = Timer.periodic(const Duration(seconds: 1),
                                  (timer) {
                                setState(() {
                                  if (_timerSeconds <= 0) {
                                    timer.cancel();
                                    updateIcon();
                                    return;
                                  }
                                  _timerSeconds -= 1;
                                  exerciseTime = setTime - _timerSeconds;
                                });
                              });
                            }
                          },
                          child: iconTimer),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            backgroundColor: MyColors.wrong,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          setState(() {
                            timer?.cancel();
                            _currentIndex = _goTimerFrom + 1;
                          });
                        },
                        child: const Icon(
                          Icons.stop_outlined,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_fire_department_outlined,
                                size: 45,
                              ),
                              Text("BURN",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                            kcalCalculator(
                                menuList[index]['title']!, exerciseTime),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
