import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tracker/controller/user_controller.dart';

class NutritionHistory {
  final num carb;
  final num fat;
  final num protein;
  final num sodium;
  final num energy;
  final num todayBurn;
  final DateTime day;
  final String userUid;

  NutritionHistory({
    required this.carb,
    required this.fat,
    required this.protein,
    required this.sodium,
    required this.energy,
    required this.todayBurn,
    required this.day,
    required this.userUid,
  });

  factory NutritionHistory.fromJson(Map<String, dynamic> json) {
    return NutritionHistory(
      carb: json['carb'],
      fat: json['fat'],
      protein: json['protein'],
      sodium: json['sodium'],
      energy: json['energy'],
      todayBurn: json['today_burn'],
      day: (json['day'].toDate()),
      userUid: json['user_id'],
    );
  }

  factory NutritionHistory.empty() {
    return NutritionHistory(
      carb: 0,
      fat: 0,
      protein: 0,
      sodium: 0,
      energy: 0,
      todayBurn: 0,
      day: DateTime.now(),
      userUid: UserController.user?.uid ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carb': carb,
      'fat': fat,
      'protein': protein,
      'sodium': sodium,
      'energy': energy,
      'today_burn': todayBurn,
      'day': Timestamp.fromDate(day),
      'user_id': userUid,
    };
  }

  @override
  String toString() {
    return 'carb: $carb, fat: $fat, protein: $protein, sodium: $sodium, todayBurn: $todayBurn, day: $day, userUid: $userUid';
  }
}
