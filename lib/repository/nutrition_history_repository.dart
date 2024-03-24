import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_tracker/models/nutrition_history.dart';

class NutritionHistoryRepository {
  CollectionReference<Map<String, dynamic>> nutritionCollections =
      FirebaseFirestore.instance.collection('nutritionHistory');
  Reference storageRef = FirebaseStorage.instance.ref();

  // Future<List<Food>> getFoods() async {
  //   final doc = await nutritionCollections.get();
  //   return doc.docs.map((e) => Food.fromJson(e.data())).toList();
  // }

  // Stream<List<Food>> getFoodsStream() {
  //   return nutritionCollections
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs)
  //       .map((docs) => docs.map((e) => Food.fromJson(e.data())).toList());
  // }

  // Reference getImageRef(String path) {
  //   return storageRef.child(path);
  // }

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

  Future<void> addNutritionHistory(
      NutritionHistory nutrition) async {
    await nutritionCollections.add(nutrition.toJson());
  }
}
