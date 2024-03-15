class Food {
  final String thaiName;
  final String englishName;
  final num energy;
  final num protein;
  final num fat;
  final num carb;
  final num fiber;
  final num sodium;
  final num sugar;
  final String? image;
  final String type;

  Food({
    required this.thaiName,
    required this.englishName,
    required this.energy,
    required this.protein,
    required this.fat,
    required this.carb,
    required this.fiber,
    required this.sodium,
    required this.sugar,
    this.image,
    required this.type,
  });

  factory Food.fromJson(Map<String, dynamic> doc) {
    return Food(
      thaiName: doc['thai_name'],
      englishName: doc['english_name'],
      energy: doc['energy'],
      protein: doc['protein'],
      fat: doc['fat'],
      carb: doc['carb'],
      fiber: doc['fiber'],
      sodium: doc['sodium'],
      sugar: doc['sugar'],
      image: doc['image_path'],
      type: doc['type'],
    );
  }
}
