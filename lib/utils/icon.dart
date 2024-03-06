import 'package:flutter/material.dart';

IconButton buildIconWithAction(String iconName, Function() onPress,
    {double width = 55, double height = 65}) {
  return IconButton(
      icon: Image.asset(
        'lib/assets/images/icons/$iconName.png',
        width: width,
        height: height,
      ),
      onPressed: onPress);
}

ImageIcon buildIcon(String iconName, {double size = 30, Color color = Colors.black}) {
  return ImageIcon(
    AssetImage('lib/assets/images/icons/$iconName.png'),
    size: size,
    color: color,
  );
}
