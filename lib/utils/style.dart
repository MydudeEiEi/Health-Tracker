import 'package:flutter/material.dart';

class MyColors {
  static const Color lightBlue = Color.fromRGBO(187, 222, 251, 1);
  static const Color blueWaterDrop = Color(0xFF11A7FC);
  static const Color redCalendar = Color(0xFFF15223);

  static const Color sleepCard = Color(0xFFBB85FF);
  static const Color fatCard = Color(0xFFFFB800);
  static const Color carbohydeateCard = Color(0xFF7CD671);
  static const Color proteinCard = Color(0xFFC0482D);
  static const Color sodiumCard = Color(0xFFBDB193);

  static const Color menuCard = Color(0xFFE9DAB5);
  static const Color activityCard = Color(0xFF1D0956);

  static const Color correct = Color(0xFF7CD671);
  static const Color wrong = Color(0xFFFF4444);

  static const LinearGradient redOrange = LinearGradient(colors: [
    Color.fromRGBO(253, 55, 31, 1),
    Color.fromRGBO(255, 132, 75, 1),
  ]);
  static const LinearGradient transparent = LinearGradient(colors: [
    Colors.transparent,
    Colors.transparent,
  ]);
}

class MyTextStyle {
  static TextStyle title({Color color = Colors.black}) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
  static TextStyle subtitle(
          {Color color = const Color.fromRGBO(97, 97, 97, 1),
          FontWeight fontWeight = FontWeight.w500}) =>
      TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);
  static TextStyle body(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.normal}) =>
      TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);
}
