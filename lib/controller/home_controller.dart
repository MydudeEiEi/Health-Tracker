import 'package:flutter/foundation.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/nutrition_history.dart';
import 'package:health_tracker/repository/health_repository.dart';
import 'package:health_tracker/models/blood_glucose.dart';
import 'package:health_tracker/repository/nutrition_history_repository.dart';

class HomeController {
  final repository = HealthRepository();
  final NutritionHistoryRepository nutritionHistoryRepository =
      NutritionHistoryRepository();
  // Future<void> getDataFirebase() async {
  //   final movieRef = FirebaseFirestore.instance
  //     .collection('movies')
  //     .withConverter<Movie>(
  //       fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
  //       toFirestore: (movie, _) => movie.toJson());

  //   final movies = await movieRef.get();
  //   print(movies.docs.map((e) => e.data()).toList());

  // }

  Future<NutritionHistory> getUserNutritionHistory() async {
    final String userId = UserController.user?.uid ?? '';
    final data = await nutritionHistoryRepository
        .getUserNutritionHistoryByUserUidAndDate(userId, DateTime.now());
    if (data != null) {
      return data;
    } else {
      final newData = NutritionHistory(
        carb: 0,
        fat: 0,
        protein: 0,
        sodium: 0,
        day: DateTime.now(),
        userUid: userId,
      );
      await nutritionHistoryRepository.addNutritionHistory(newData);
      return newData;
    }
  }

  final bloodGlucoses = ValueNotifier(<BloodGlucose>[]);
  Future<void> getData() async {
    bloodGlucoses.value = await repository.getBloodGlucose();
  }
}
