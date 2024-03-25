import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/controller/user_controller.dart';

class ProfileImg extends StatelessWidget {
  final Widget page;
  const ProfileImg(this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      closedBuilder: (context, action) {
        return Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: InkWell(
            child: CircleAvatar(
              radius: 25,
              foregroundImage:
                  NetworkImage(UserController.user?.photoURL ?? ''),
            ),
          ),
        );
      },
      openBuilder: (context, action) => page,
    );
  }
}
