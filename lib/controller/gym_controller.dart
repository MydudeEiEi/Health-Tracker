import 'package:health_tracker/repository/nutrition_history_repository.dart';

class GymController {
  final NutritionHistoryRepository nutritionHistoryRepository =
      NutritionHistoryRepository();

  Future<void> updateTodayBurnByUserId(String userId, num exerciseBurn) async {
    await nutritionHistoryRepository.addTodayBurnByUserId(userId, exerciseBurn);
  }
}