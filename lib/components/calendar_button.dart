import 'package:flutter/material.dart';
import 'package:health_tracker/utils/style.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({Key? key}) : super(key: key);

  void _onTapCalendar() {}

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        //This keeps the splash effect within the circle
        borderRadius:
            BorderRadius.circular(25.0), //Something large to ensure a circle
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
    );
  }
}
