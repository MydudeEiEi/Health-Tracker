import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tracker/models/food.dart';
import 'package:health_tracker/models/nutrition_history.dart';

class NutritionHistoryRepository {
  CollectionReference<Map<String, dynamic>> nutritionCollections =
      FirebaseFirestore.instance.collection('nutritionHistory');

  Future<NutritionHistory?> getUserNutritionHistoryByUserUidAndDate(
      String userId, DateTime date) async {
    final startDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day));
    final endDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day + 1));
    final doc = await nutritionCollections
        .where('user_id', isEqualTo: userId)
        .where('day', isGreaterThanOrEqualTo: startDate)
        .where('day', isLessThan: endDate)
        .get();
    final data =
        doc.docs.map((e) => NutritionHistory.fromJson(e.data())).toList();
    if (data.isEmpty) {
      return null;
    }
    return (doc.docs
        .map((e) => NutritionHistory.fromJson(e.data()))
        .toList())[0];
  }

  Future<void> addNutritionHistory(NutritionHistory nutrition) async {
    await nutritionCollections.add(nutrition.toJson());
  }

  Future<void> addNutritionHistoryById(String userId, Food food) async {
    final date = DateTime.now();
    final startDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day));
    final endDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day + 1));
    final doc = await nutritionCollections
        .where('user_id', isEqualTo: userId)
        .where('day', isGreaterThanOrEqualTo: startDate)
        .where('day', isLessThan: endDate)
        .get();
    if (doc.docs.isEmpty) {
      print('add nutrition history failed because data is empty');
      return;
    }
    final data = NutritionHistory.fromJson(doc.docs[0].data());
    final id = doc.docs[0].id;
    await nutritionCollections.doc(id).update({
      'carb': num.parse((data.carb + food.carb).toStringAsFixed(1)),
      'fat': num.parse((data.fat + food.fat).toStringAsFixed(1)),
      'protein': num.parse((data.protein + food.protein).toStringAsFixed(1)),
      'sodium': num.parse((data.sodium + food.sodium).toStringAsFixed(1)),
      'energy': num.parse((data.energy + food.energy).toStringAsFixed(1)),
    });
  }

  Future<void> addTodayBurnByUserId(String userId, num exerciseBurn) async {
    final date = DateTime.now();
    final startDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day));
    final endDate =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day + 1));
    final doc = await nutritionCollections
        .where('user_id', isEqualTo: userId)
        .where('day', isGreaterThanOrEqualTo: startDate)
        .where('day', isLessThan: endDate)
        .get();
    if (doc.docs.isEmpty) {
      print('add today burn failed because data is empty');
      return;
    }
    final data = NutritionHistory.fromJson(doc.docs[0].data());
    final id = doc.docs[0].id;
    await nutritionCollections.doc(id).update({
      'today_burn': num.parse((data.todayBurn + exerciseBurn).toString()),
    });
  }
}
