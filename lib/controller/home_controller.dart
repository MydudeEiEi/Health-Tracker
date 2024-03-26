import 'package:flutter/foundation.dart';
import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/nutrition_history.dart';
import 'package:health_tracker/models/user_information.dart';
import 'package:health_tracker/repository/health_repository.dart';
import 'package:health_tracker/models/blood_glucose.dart';
import 'package:health_tracker/repository/nutrition_history_repository.dart';
import 'package:health_tracker/repository/user_information_repository.dart';

class HomeController {
  final repository = HealthRepository();
  final NutritionHistoryRepository nutritionHistoryRepository =
      NutritionHistoryRepository();
  final UserInformationRepository userInformationRepository =
      UserInformationRepository();
  // Future<void> getDataFirebase() async {
  //   final movieRef = FirebaseFirestore.instance
  //     .collection('movies')
  //     .withConverter<Movie>(
  //       fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
  //       toFirestore: (movie, _) => movie.toJson());

  //   final movies = await movieRef.get();
  //   print(movies.docs.map((e) => e.data()).toList());

  // }

  Future<NutritionHistory> getUserNutritionHistory(
      DateTime selectedDate) async {
    final String userId = UserController.user?.uid ?? '';
    final data = await nutritionHistoryRepository
        .getUserNutritionHistoryByUserUidAndDate(userId, selectedDate);
    if (data != null) {
      return data;
    } else {
      final newData = NutritionHistory.empty();
      await nutritionHistoryRepository.addNutritionHistory(newData);
      return newData;
    }
  }

  final bloodGlucoses = ValueNotifier(<BloodGlucose>[]);
  Future<void> getData() async {
    bloodGlucoses.value = await repository.getBloodGlucose();
  }

  Future<UserInformation> getUserInformationByUserUid(String userId) async {
    return userInformationRepository.getUserInformationByUserUid(userId);
  }
}
