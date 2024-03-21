import 'package:flutter/material.dart';

enum SnackBarType { success, error, info }

SnackBar mySnackBar(SnackBarType type, String message,
    {TextStyle textStyle = const TextStyle(color: Colors.black)}) {
  Color color;

  switch (type) {
    case SnackBarType.success:
      color = Colors.green;
      break;
    case SnackBarType.error:
      color = Colors.red;
      break;
    case SnackBarType.info:
      color = Colors.white;
      break;
  }

  return SnackBar(
    content: Text(message, style: textStyle),
    duration: const Duration(seconds: 3, microseconds: 500),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
    backgroundColor: color,
  );
}
