import 'package:cloud_firestore/cloud_firestore.dart';

class NutritionHistory {
  final num carb;
  final num fat;
  final num protein;
  final num sodium;
  final num energy;
  final DateTime day;
  final String userUid;

  NutritionHistory({
    required this.carb,
    required this.fat,
    required this.protein,
    required this.sodium,
    required this.energy,
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
      day: (json['day'].toDate()),
      userUid: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carb': carb,
      'fat': fat,
      'protein': protein,
      'sodium': sodium,
      'energy': energy,
      'day': Timestamp.fromDate(day),
      'user_id': userUid,
    };
  }

  @override
  String toString() {
    return 'carb: $carb, fat: $fat, protein: $protein, sodium: $sodium, day: $day, userUid: $userUid';
  }
}
