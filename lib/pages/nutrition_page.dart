import 'package:flutter/material.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/controller/nutrition_controller.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NutritionPage extends StatelessWidget {
  List<num> allData;
  Color _backgroundColor;
  String imageName;
  String unit;
  final DateTime today = DateTime.now();
  final NutritionType type;

  NutritionPage(this.type, {Key? key})
      : allData = [],
        imageName = '',
        unit = '',
        _backgroundColor = Colors.white,
        super(key: key) {
    final NutritionController cnotroller = NutritionController();
    switch (type) {
      case NutritionType.fat:
        _backgroundColor = MyColors.fatCard;
        imageName = "fat";
        unit = 'Kcal';
        allData = cnotroller.getFatHistory();
        break;
      case NutritionType.carbohydeate:
        _backgroundColor = MyColors.carbohydeateCard;
        imageName = "wheet";
        unit = 'G';
        allData = cnotroller.getFatHistory();
        break;
      case NutritionType.protein:
        _backgroundColor = MyColors.proteinCard;
        imageName = "protein";
        unit = 'G';
        allData = cnotroller.getFatHistory();
        break;
      case NutritionType.sodium:
        _backgroundColor = MyColors.sodiumCard;
        imageName = "sodium";
        unit = 'MG';
        allData = cnotroller.getFatHistory();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double topScreenMargin = MediaQuery.of(context).viewPadding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: topScreenMargin + 10, bottom: topScreenMargin * .25),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(.1)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .1, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              index == 0
                                  ? 'Today'
                                  : DateFormat('EEEE, d MMMM').format(
                                      today.subtract(Duration(days: index))),
                              style:
                                  MyTextStyle.body(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _backgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              buildIcon(imageName, size: 55),
                              Expanded(
                                  child: Center(
                                      child: Text('${allData[index]} $unit',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(.1)))),
            height: 80,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: InkWell(
                  child: buildIcon('home'),
                  onTap: () => {Navigator.pop(context)},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
