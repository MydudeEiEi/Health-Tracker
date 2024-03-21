import 'package:flutter/material.dart';
import 'package:health_tracker/components/nutrition_card.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/controller/home_controller.dart';
import 'package:health_tracker/pages/nutrition_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
        // floatingActionButton: Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     const SizedBox(height: 16),
        //     FloatingActionButton(
        //       onPressed: () => controller.getData(),
        //       child: const Icon(Icons.refresh),
        //     )
        //   ],
        // ),
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * .025),
      child: Column(
        children: [
          Container(
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
                      child:
                          buildIcon("bedtime", color: Colors.white, size: 60)),
                  const Spacer(),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sleeping",
                        style: MyTextStyle.title(color: Colors.white),
                      ),
                      Text(
                        "8",
                        style: MyTextStyle.title(color: Colors.white),
                      ),
                      Text(
                        "Hour",
                        style: MyTextStyle.title(color: Colors.white),
                      )
                    ],
                  )),
                  const Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHight * .01),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "1535",
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
                      "500",
                      style: MyTextStyle.title(),
                    ),
                    Text(
                      "Total Burn calories",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text("2000", style: MyTextStyle.title()),
                    Text(
                      "Total calories",
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
                      NutritionCardType.fat, NutritionPage(NutritionType.fat))),
              Expanded(
                  child: NutritionCard(NutritionCardType.carbohydeate,
                      NutritionPage(NutritionType.carbohydeate))),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: NutritionCard(NutritionCardType.protein,
                      NutritionPage(NutritionType.protein))),
              Expanded(
                  child: NutritionCard(NutritionCardType.sodium,
                      NutritionPage(NutritionType.sodium))),
            ],
          ),
          SizedBox(height: screenHight * .02),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "7580 m",
                      style: MyTextStyle.title(),
                    ),
                    Text(
                      "Distance",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      "9832",
                      style: MyTextStyle.title(),
                    ),
                    Text(
                      "Steps",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Text("1248", style: MyTextStyle.title()),
                    Text(
                      "Minutes",
                      style: MyTextStyle.subtitle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
