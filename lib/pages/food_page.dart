import 'package:flutter/material.dart';
import 'package:health_tracker/components/recommended_menu_card.dart';
import 'package:health_tracker/controller/food_controller.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FoodController foodController = FoodController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: foodController.getFoodsStream(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final foods = snapshot.data!;
              return ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return FutureBuilder(
                        future: foodController.loadImage(food.image),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return RecommendedMenuCard(
                            food: food,
                            imagePath: snapshot.data.toString(),
                            onTap: () => {},
                          );
                        });
                  });
            }
            return const Text("No data");
          }),
    );
  }
}
