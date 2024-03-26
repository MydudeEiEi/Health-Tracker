import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/firebase_options.dart';
import 'package:health_tracker/pages/main_page.dart';
import 'package:health_tracker/utils/notification_service.dart';
import 'pages/login_page.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: UserController.user != null ? const MainPage() : const LoginPage(),
    );
  }
}
