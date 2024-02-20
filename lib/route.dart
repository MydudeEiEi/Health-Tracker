import 'package:flutter/material.dart';
import 'package:health_tracker/pages/home_page.dart';
import 'package:health_tracker/pages/login_page.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  "/home": (BuildContext context) =>  HomePage(),
  "/login": (BuildContext context) => const LoginPage(),
};
