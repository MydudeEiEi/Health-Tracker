import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/pages/water_notification_page.dart';
import 'package:health_tracker/utils/style.dart';

class WaterDropButton extends StatelessWidget {
  const WaterDropButton({Key? key}) : super(key: key);

  void _onTapWaterDrop() {}

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openBuilder: (context, action) => const WaterNotificationPage(),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      closedBuilder: (context, action) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.water_drop_rounded,
            size: 26,
            color: MyColors.blueWaterDrop,
          ),
        ),
      ),
    );
  }
}
