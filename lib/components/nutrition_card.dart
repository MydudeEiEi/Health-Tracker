import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker/models/nutrition_history.dart';
import 'package:health_tracker/utils/icon.dart';
import 'package:health_tracker/utils/style.dart';

enum NutritionCardType {
  fat,
  carbohydeate,
  protein,
  sodium,
}

// ignore: must_be_immutable
class NutritionCard extends StatelessWidget {
  Color _backgroundColor;
  String _iconName;
  String _cardLable;
  String _cardDetail;
  Widget nextPage;
  NutritionHistory data;

  NutritionCard(NutritionCardType cardType, this.nextPage, this.data,
      {Key? key})
      : _backgroundColor = Colors.grey[100]!,
        _iconName = "",
        _cardLable = "",
        _cardDetail = "",
        super(key: key) {
    switch (cardType) {
      case NutritionCardType.fat:
        _backgroundColor = MyColors.fatCard;
        _iconName = "fat";
        _cardLable = "FAT";
        _cardDetail = "${data.fat} kcal";
        break;
      case NutritionCardType.carbohydeate:
        _backgroundColor = MyColors.carbohydeateCard;
        _iconName = "wheet";
        _cardLable = "CARBOHYDEATE";
        _cardDetail = "${data.carb} G";
        break;
      case NutritionCardType.protein:
        _backgroundColor = MyColors.proteinCard;
        _iconName = "protein";
        _cardLable = "PROTEIN";
        _cardDetail = "${data.protein} G";
        break;
      case NutritionCardType.sodium:
        _backgroundColor = MyColors.sodiumCard;
        _iconName = "sodium";
        _cardLable = "SODIUM";
        _cardDetail = "${data.sodium} MG";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: OpenContainer(
        openBuilder: (context, action) => nextPage,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        closedBuilder: (context, action) => Container(
          decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(20),
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
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildIcon(_iconName, size: 70),
                  ),
                  Text(
                    _cardDetail,
                    style: MyTextStyle.title(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _cardLable,
                    style: MyTextStyle.title(color: Colors.white),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
