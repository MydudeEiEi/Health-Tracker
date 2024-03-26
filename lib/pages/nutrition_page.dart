import 'package:flutter/material.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/components/water_drop_button.dart';
import 'package:health_tracker/controller/nutrition_controller.dart';
import 'package:health_tracker/pages/main_page.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';
import 'package:intl/intl.dart';

class NutritionPage extends StatefulWidget {
  final DateTime today = DateTime.now();
  final NutritionType type;

  NutritionPage(this.type, {Key? key}) : super(key: key);

  @override
  State<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  List<num> allData = [];
  Color _backgroundColor = Colors.white;
  String imageName = '';
  String unit = '';

  void initialize() {
    final NutritionController controller = NutritionController();

    setState(() {
      switch (widget.type) {
        case NutritionType.fat:
          _backgroundColor = MyColors.fatCard;
          imageName = "fat";
          unit = 'Kcal';
          controller.getFatHistory().then((value) {
            if (mounted) {
              setState(() {
                allData = value;
              });
            }
          });
          break;
        case NutritionType.carbohydeate:
          _backgroundColor = MyColors.carbohydeateCard;
          imageName = "wheet";
          unit = 'G';
          controller.getCarbHistory().then((value) {
            if (mounted) {
              setState(() {
                allData = value;
              });
            }
          });
          break;
        case NutritionType.protein:
          _backgroundColor = MyColors.proteinCard;
          imageName = "protein";
          unit = 'G';
          controller.getProteinHistory().then((value) {
            if (mounted) {
              setState(() {
                allData = value;
              });
            }
          });
          break;
        case NutritionType.sodium:
          _backgroundColor = MyColors.sodiumCard;
          imageName = "sodium";
          unit = 'MG';
          controller.getSodiumHistory().then((value) {
            if (mounted) {
              setState(() {
                allData = value;
              });
            }
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double topScreenMargin = MediaQuery.of(context).viewPadding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    initialize();

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: topScreenMargin + 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(.1)))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * .025,
                  right: screenWidth * .025,
                  bottom: screenWidth * .025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const Spacer(),
                  const WaterDropButton(),
                  SizedBox(width: screenWidth * .025),
                ],
              ),
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
                                  : DateFormat('EEEE, d MMMM').format(widget
                                      .today
                                      .subtract(Duration(days: index))),
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
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()))
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
