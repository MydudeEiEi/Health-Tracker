import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors {
  static const Color lightBlue = Color.fromRGBO(187, 222, 251, 1);
  static const LinearGradient redOrange = LinearGradient(colors: [
    Color.fromRGBO(253, 55, 31, 1),
    Color.fromRGBO(255, 132, 75, 1),
  ]);
  static const LinearGradient transparent = LinearGradient(colors: [
    Colors.transparent,
    Colors.transparent,
  ]);
}
