class UserInformation {
  final String userId;
  final String gender;
  final num age;
  final num height;
  final num weight;

  UserInformation({
    required this.userId,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      userId: json['user_id'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  factory UserInformation.empty({String userId = ''}) {
    return UserInformation(
      userId: userId,
      gender: 'other',
      age: 0,
      height: 0,
      weight: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }
}
