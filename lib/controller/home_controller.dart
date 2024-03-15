import 'package:flutter/foundation.dart';
import 'package:health_tracker/repository/health_repository.dart';
import 'package:health_tracker/models/blood_glucose.dart';

class HomeController {

  final repository = HealthRepository();
  // Future<void> getDataFirebase() async {
  //   final movieRef = FirebaseFirestore.instance
  //     .collection('movies')
  //     .withConverter<Movie>(
  //       fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
  //       toFirestore: (movie, _) => movie.toJson());

  //   final movies = await movieRef.get();
  //   print(movies.docs.map((e) => e.data()).toList());

  // }



  final bloodGlucoses = ValueNotifier(<BloodGlucose>[]);
  Future<void> getData() async {
    bloodGlucoses.value = await repository.getBloodGlucose();
  }
}

class Movie {
  final String id;
  final String name;

  Movie(this.id, this.name);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['id'] as String,
      json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}