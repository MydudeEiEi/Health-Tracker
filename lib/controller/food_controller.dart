import 'package:health_tracker/controller/user_controller.dart';
import 'package:health_tracker/models/food.dart';
import 'package:health_tracker/repository/food_repository.dart';
import 'package:health_tracker/repository/nutrition_history_repository.dart';

class FoodController {
  FoodRepository foodRepository = FoodRepository();
  NutritionHistoryRepository nutritionHistoryRepository =
      NutritionHistoryRepository();

  Stream<List<Food>> getFoodsStream() {
    return foodRepository.getFoodsStream();
  }

  Future<String> loadImage(String? path) async {
    const defaultMenuImage = 'https://picsum.photos/250?image=9';
    if (path == null) return defaultMenuImage;
    try {
      if (path.startsWith('http')) return path;
      final ref = foodRepository.getImageRef(path);
      final url = (await ref.getDownloadURL()).toString();
      return url;
    } catch (e) {
      print(e);
    }
    return path;
  }

  Future<void> selectFood(Food food) async {
    await nutritionHistoryRepository.addNutritionHistoryById(
        UserController.user!.uid, food);
  }
}
