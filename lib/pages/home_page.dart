import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/components/nutrition_card.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/controller/home_controller.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/nutrition_history.dart';
import 'package:health_tracker/pages/main_page.dart';
import 'package:health_tracker/pages/nutrition_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage(
    this.selectedDate, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  int bmr = 0;

  _HomePageState() {
    calculateBMR();
  }

  NutritionHistory userNutritionData = NutritionHistory.empty();

  void loadNutritionData() {
    controller.getUserNutritionHistory(widget.selectedDate).then((value) {
      setState(() {
        userNutritionData = value;
      });
    });
  }

  void calculateBMR() {
    controller
        .getUserInformationByUserUid(UserController.user!.uid)
        .then((value) {
      setState(() {
        if (value.gender.toLowerCase() == 'male') {
          bmr = (66 +
                  (13.7 * value.weight) +
                  (5 * value.height) -
                  (6.8 * value.age))
              .toInt();
        } else if (value.gender.toLowerCase() == 'female') {
          bmr = (655 +
                  (9.6 * value.weight) +
                  (1.8 * value.height) -
                  (4.7 * value.age))
              .toInt();
        } else {
          bmr = 0;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadNutritionData();
    calculateBMR();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * .025, vertical: 15),
      child: Column(
        children: [
          OpenContainer(
            openBuilder: (context, action) => const MainPage(
              indexPage: 0,
            ),
            closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            closedBuilder: (context, action) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.0),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0.0, 3.0),
                        blurRadius: 1.0,
                        spreadRadius: -2.0,
                        color: Colors.black.withOpacity(.1)),
                    BoxShadow(
                        offset: const Offset(0.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.black.withOpacity(.1)),
                    BoxShadow(
                        offset: const Offset(0.0, 1.0),
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(.1)),
                  ]),
              height: 135,
              child: Card(
                color: MyColors.sleepCard,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(
                        child: buildIcon("salad",
                            color: Colors.black, size: 70)),
                    const Spacer(),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "RECOMMENDED",
                          style: MyTextStyle.title(color: Colors.white),
                        ),
                        Text(
                          "HEALTHY",
                          style: MyTextStyle.title(color: Colors.white),
                        ),
                        Text(
                          "FOOD",
                          style: MyTextStyle.title(color: Colors.white),
                        )
                      ],
                    )),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenHight * .01),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "$bmr",
                      style: MyTextStyle.title(),
                    ),
                    Text(
                      "BMR",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      (userNutritionData.todayBurn + bmr).toStringAsFixed(0),
                      style: MyTextStyle.title(),
                    ),
                    Text(
                      "Total Burn",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "calories",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(userNutritionData.energy.toStringAsFixed(0),
                        style: MyTextStyle.title()),
                    Text(
                      "Total",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "calories",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(height: screenHight * .025),
          Row(
            children: [
              Expanded(
                  child: NutritionCard(
                      NutritionCardType.fat,
                      NutritionPage(
                        NutritionType.fat,
                      ),
                      userNutritionData)),
              Expanded(
                  child: NutritionCard(
                      NutritionCardType.carbohydeate,
                      NutritionPage(NutritionType.carbohydeate),
                      userNutritionData)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: NutritionCard(NutritionCardType.protein,
                      NutritionPage(NutritionType.protein), userNutritionData)),
              Expanded(
                  child: NutritionCard(NutritionCardType.sodium,
                      NutritionPage(NutritionType.sodium), userNutritionData)),
            ],
          ),
        ],
      ),
    ));
  }
}
