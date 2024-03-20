import 'package:flutter/material.dart';
import 'package:health_tracker/models/food.dart';
import 'package:health_tracker/utils/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

enum NutritionType {
  fat,
  carbohydeate,
  protein,
  sodium,
}

class RecommendedMenuCard extends StatelessWidget {
  final Food food;
  final String imagePath;
  final Function() onTap;

  const RecommendedMenuCard(
      {Key? key,
      required this.food,
      required this.imagePath,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double barWidth = screenWidth * .35;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Center(
          child: Ink(
              decoration: const BoxDecoration(
                  color: MyColors.menuCard,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: double.infinity,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "RECOMMENDED HEALTHY MENU",
                        style: MyTextStyle.title(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 25),
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Text(food.englishName,
                          style: MyTextStyle.subtitle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text("${food.energy} Kcal",
                          style: MyTextStyle.body(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Spacer(),
                          buildNutritionBar(NutritionType.fat, food, barWidth),
                          const Spacer(),
                          buildNutritionBar(
                              NutritionType.carbohydeate, food, barWidth),
                          const Spacer()
                        ],
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          buildNutritionBar(
                              NutritionType.protein, food, barWidth),
                          const Spacer(),
                          buildNutritionBar(
                              NutritionType.sodium, food, barWidth),
                          const Spacer()
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget buildNutritionBar(NutritionType type, Food food, double width) {
    String title = "";
    num value = 0.0;
    Color barColor = Colors.white;
    switch (type) {
      case NutritionType.fat:
        title = "FAT";
        value = food.fat;
        barColor = MyColors.fatCard;
        break;
      case NutritionType.carbohydeate:
        title = "CARBOHYDEATE";
        value = food.carb;
        barColor = MyColors.carbohydeateCard;
        break;
      case NutritionType.protein:
        title = "PROTEIN";
        value = food.protein;
        barColor = MyColors.proteinCard;
        break;
      case NutritionType.sodium:
        title = "SODIUM";
        value = food.sodium;
        barColor = MyColors.sodiumCard;
        break;
    }

    double percent = value / 100;
    if (percent > 100) {
      percent = 100;
    } else if (percent < 0.05) {
      percent = 0.05;
    }

    return Column(
      children: [
        Text(title, style: MyTextStyle.body()),
        LinearPercentIndicator(
          barRadius: const Radius.circular(25),
          animation: true,
          lineHeight: 5,
          width: width,
          animationDuration: 500,
          percent: percent,
          progressColor: barColor,
        ),
        Text("$value Kcal", style: MyTextStyle.body()),
      ],
    );
  }
}
