import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/components/my_card.dart';
import 'package:health_tracker/controller/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/pages/login_page.dart';
import 'package:health_tracker/models/blood_glucose.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => controller.getData(),
            child: const Icon(Icons.refresh),
          )
        ],
      ),

body: Stack(
  fit: StackFit.expand, // make the stack fill the available space
  children: <Widget>[
    Positioned(
      top: 20, // reduce the top margin of the user image, user name, and logout button
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(UserController.user?.photoURL ?? ''),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE, d MMMM').format(DateTime.now()),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                UserController.user?.displayName ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
    Positioned(
      top: 10, // reduce the top margin of the logout button
      right: 10,
      child: ElevatedButton(
        onPressed: () async {
          bool confirmLogout = await UserController.signOutConfirmation(context);
          if (confirmLogout) {
            await UserController.signOut();
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
          }
        },
        child: const Text("Logout"),
      ),
    ),
    Align(
      alignment: Alignment.center, // position the grid of cards in the center of the screen
      child: ValueListenableBuilder<List<BloodGlucose>>(
        valueListenable: controller.bloodGlucoses,
        builder: (context, bloodGlucoses, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: bloodGlucoses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return MyCard(bloodGlucose: bloodGlucoses[index]);
            },
          );
        },
      ),
    ),
    Positioned(
      bottom: 0, // reduce the bottom margin of the bottom row of icon buttons
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(187, 222, 251, 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIconButton('lib/images/dish.png'),
            const SizedBox(width: 51),
            _buildGradientIconButton('lib/images/home_btn.png'),
            const SizedBox(width: 51),
            _buildIconButton('lib/images/dumbbell.png'),
          ],
        ),
      ),
    ),
  ],
),
    );
  }

  IconButton _buildIconButton(String imagePath) {
    return IconButton(
      icon: Image.asset(
        imagePath,
        width: 55,
        height: 65,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }

  IconButton _buildGradientIconButton(String imagePath) {
    return IconButton(
      icon: Container(
        width: 55,
        height: 65,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(253, 55, 31, 1),
              Color.fromRGBO(255, 132, 75, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
  }
}
