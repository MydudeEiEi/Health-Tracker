import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/nutrition_history.dart';
import 'package:health_tracker/repository/nutrition_history_repository.dart';

class NutritionController {
  final NutritionHistoryRepository nutritionHistoryRepository =
      NutritionHistoryRepository();
  List<NutritionHistory> nutritionHistory = [];

  Future<List<num>> getFatHistory() async {
    nutritionHistory = await nutritionHistoryRepository
        .getUserNutritionHistoryLast7DaysByUserUid(UserController.user!.uid);

    List<num> fatHistory = [];
    final now = DateTime.now();
    int day = 0;
    int index = 0;
    while (day < 7 && index < nutritionHistory.length) {
      final date = DateTime(now.year, now.month, now.day - day);
      if (nutritionHistory[index].day.isSameDate(date)) {
        fatHistory.add(nutritionHistory[index].fat);
        index++;
      } else {
        fatHistory.add(0);
      }
      day++;
    }
    print(fatHistory  );
    while (day < 7) {
      fatHistory.add(0);
      day++;
    }
    return fatHistory;
  }

  Future<List<num>> getCarbHistory() async {
    nutritionHistory = await nutritionHistoryRepository
        .getUserNutritionHistoryLast7DaysByUserUid(UserController.user!.uid);

    List<num> carbHistory = [];
    final now = DateTime.now();
    int day = 0;
    int index = 0;
    while (day < 7 && index < nutritionHistory.length) {
      final date = DateTime(now.year, now.month, now.day - day);
      if (nutritionHistory[index].day.isSameDate(date)) {
        carbHistory.add(nutritionHistory[index].carb);
        index++;
      } else {
        carbHistory.add(0);
      }
      day++;
    }
    while (day < 7) {
      carbHistory.add(0);
      day++;
    }
    return carbHistory;
  }

  Future<List<num>> getProteinHistory() async {
    nutritionHistory = await nutritionHistoryRepository
        .getUserNutritionHistoryLast7DaysByUserUid(UserController.user!.uid);

    List<num> proteinHistory = [];
    final now = DateTime.now();
    int day = 0;
    int index = 0;
    while (day < 7 && index < nutritionHistory.length) {
      final date = DateTime(now.year, now.month, now.day - day);
      if (nutritionHistory[index].day.isSameDate(date)) {
        proteinHistory.add(nutritionHistory[index].protein);
        index++;
      } else {
        proteinHistory.add(0);
      }
      day++;
    }
    while (day < 7) {
      proteinHistory.add(0);
      day++;
    }
    return proteinHistory;
  }

  Future<List<num>> getSodiumHistory() async {
    nutritionHistory = await nutritionHistoryRepository
        .getUserNutritionHistoryLast7DaysByUserUid(UserController.user!.uid);

    List<num> sodiumHistory = [];
    final now = DateTime.now();
    int day = 0;
    int index = 0;
    while (day < 7 && index < nutritionHistory.length) {
      final date = DateTime(now.year, now.month, now.day - day);
      if (nutritionHistory[index].day.isSameDate(date)) {
        sodiumHistory.add(nutritionHistory[index].sodium);
        index++;
      } else {
        sodiumHistory.add(0);
      }
      day++;
    }
    while (day < 7) {
      sodiumHistory.add(0);
      day++;
    }
    return sodiumHistory;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
