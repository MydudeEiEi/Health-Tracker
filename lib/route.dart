import 'package:flutter/material.dart';
import 'package:health_tracker/pages/login_page.dart';
import 'package:health_tracker/pages/main_page.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder> {
  "/home": (BuildContext context) =>  const MainPage(),
  "/login": (BuildContext context) => const LoginPage(),
};
