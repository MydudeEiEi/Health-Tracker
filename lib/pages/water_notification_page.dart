import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:health_tracker/components/my_snackbar.dart';
import 'package:health_tracker/controller/water_notification_controller.dart';
import 'package:health_tracker/models/water_notification.dart';
import 'package:health_tracker/pages/main_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';

class WaterNotificationPage extends StatefulWidget {
  const WaterNotificationPage({Key? key}) : super(key: key);

  @override
  State<WaterNotificationPage> createState() => _WaterNotificationPageState();
}

class _WaterNotificationPageState extends State<WaterNotificationPage> {
  final WaterNotificationController controller = WaterNotificationController();
  List<WaterNotification> allNotification = [];
  final DateTime today = DateTime.now();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      return null;
    },
  );

  @override
  void initState() {
    super.initState();
    loadNotification();
  }

  void loadNotification() {
    setState(() {
      controller.getWaterNotifications().then(
            (value) => {
              setState(() {
                allNotification = value;
              })
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double topScreenMargin = MediaQuery.of(context).viewPadding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.only(top: topScreenMargin + 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(.1)))),
        child: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * .025,
              right: screenWidth * .025,
              bottom: screenWidth * .025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const Spacer(),
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        is24HrFormat: true,
                        value: Time(hour: today.hour, minute: today.minute),
                        accentColor: Colors.black,
                        buttonStyle: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(color: Colors.black)),
                        ),
                        onChange: (Time time) => {
                          controller.addNewWaterNotification(
                              time.hour, time.minute),
                          loadNotification(),
                          ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                              SnackBarType.success,
                              "Add new notification success.",
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
          child: ListView.builder(
              itemCount: allNotification.length,
              itemBuilder: ((context, index) {
                if (allNotification.isEmpty) {
                  return const Center(child: Text("No data"));
                }
                final notification = allNotification[index];
                bool isOn = notification.state == "on";

                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * .075, vertical: 3),
                  decoration: const BoxDecoration(
                    color: MyColors.fatCard,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        extentRatio: 0.4,
                        openThreshold: 0.15,
                        closeThreshold: 0.15,
                        children: [
                          SlidableAction(
                            onPressed: (context) => {
                              controller.deleteWaterNotification(
                                  int.parse(notification.hour),
                                  int.parse(notification.minute)),
                              loadNotification(),
                              ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                                  SnackBarType.success,
                                  "Delete notification success.",
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)))
                            },
                            label: 'Delete',
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          ),
                        ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${notification.hour} : ${notification.minute.padLeft(2, '0')}',
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: screenWidth * .2,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  value: isOn,
                                  overlayColor: overlayColor,
                                  activeTrackColor: MyColors.correct,
                                  inactiveTrackColor: Colors.grey[200],
                                  inactiveThumbColor: Colors.grey,
                                  thumbIcon: thumbIcon,
                                  onChanged: (value) => {
                                    controller.chageWaterNotificationState(
                                        int.parse(notification.hour),
                                        int.parse(notification.minute),
                                        value),
                                    loadNotification()
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }))),
      Ink(
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.black.withOpacity(.1)))),
          height: 80,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                child: buildIcon('home'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainPage()))
                },
              ),
            ),
          ),
        ),
      )
    ]));
  }
}
