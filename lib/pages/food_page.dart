import 'package:flutter/material.dart';
import 'package:health_tracker/components/my_snackbar.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/controller/food_controller.dart';
import 'package:health_tracker/models/food.dart';
import 'package:health_tracker/utils/style.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FoodController foodController = FoodController();

  void selectRecommendedFood(Food food) {
    foodController.selectFood(food);
  }

  @override
  Widget build(BuildContext context) {
    BuildContext thisContext = context;
    return Scaffold(
      body: StreamBuilder(
          stream: foodController.getFoodsStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              final foods = snapshot.data!;
              foods.shuffle();
              return ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return FutureBuilder(
                        future: foodController.loadImage(food.image),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const Icon(Icons.error);
                          }
                          return RecommendedMenuCard(
                            food: food,
                            imagePath: snapshot.data.toString(),
                            onTap: () => {
                              showDialog(
                                  context: thisContext,
                                  builder: (context) {
                                    return _selectMenuPopup(context, food,
                                        snapshot.data.toString());
                                  })
                            },
                          );
                        });
                  });
            }
            return const Text("No data");
          }),
    );
  }

  Widget _selectMenuPopup(BuildContext context, Food food, String imagePath) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * .025,
        right: screenWidth * .025,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Dialog(
            insetPadding: const EdgeInsets.only(left: 0, right: 0, top: 80),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: MyColors.menuCard,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.topRight,
                        child: CloseButton(
                          onPressed: () => {
                            Navigator.of(context).pop(),
                          },
                          color: Colors.black,
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 8, left: 25, right: 25),
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
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Text("${food.energy} Kcal",
                        style: MyTextStyle.body(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Spacer(),
                        Column(children: [
                          Text("FAT", style: MyTextStyle.body()),
                          Text("${food.fat} Kcal", style: MyTextStyle.body()),
                          const SizedBox(height: 10),
                          Text("PROTEIN", style: MyTextStyle.body()),
                          Text("${food.protein} G", style: MyTextStyle.body()),
                        ]),
                        const Spacer(),
                        Column(children: [
                          Text("CARBOHYDRATE", style: MyTextStyle.body()),
                          Text("${food.carb} G", style: MyTextStyle.body()),
                          const SizedBox(height: 10),
                          Text("SODIUM", style: MyTextStyle.body()),
                          Text("${food.sodium} MG", style: MyTextStyle.body()),
                        ]),
                        const Spacer(),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              selectRecommendedFood(food),
                              Navigator.of(context).pop(),
                              ScaffoldMessenger.of(context).showSnackBar(
                                  mySnackBar(SnackBarType.success,
                                      "Selected food successfully!",
                                      textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)))
                            },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        const BorderSide(color: Colors.black))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.correct)),
                        child: const Text(
                          "Select",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
