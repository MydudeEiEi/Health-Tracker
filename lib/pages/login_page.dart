import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/pages/home_page.dart';
import 'package:iconly/iconly.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 206, 173, 102),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Logo
              const Icon(
                Icons.local_drink,
                size: 100,
              ),

              const SizedBox(height: 50),

              // Welcome message
              Text(
                'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Google sign-in button
              FilledButton.tonalIcon(
                onPressed: () async {
                  try {
                    final user = await UserController.loginWithGoogle();
                    if (user != null && context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  } on FirebaseAuthException catch (error) {
                    print(error.message);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.message ?? "Something went wrong",
                        ),
                      ),
                    );
                  } catch (error) {
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error.toString(),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(IconlyLight.login),
                label: const Text("Continue with Google"),
              ),

              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
