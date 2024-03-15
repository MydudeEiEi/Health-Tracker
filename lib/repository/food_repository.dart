import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_tracker/models/food.dart';

class FoodRepository {
  CollectionReference<Map<String, dynamic>> foodCollections =
      FirebaseFirestore.instance.collection('foods');
  Reference storageRef = FirebaseStorage.instance.ref();

  Future<List<Food>> getFoods() async {
    final doc = await foodCollections.get();
    return doc.docs.map((e) => Food.fromJson(e.data())).toList();
  }

  Stream<List<Food>> getFoodsStream() {
    return foodCollections
        .snapshots()
        .map((snapshot) => snapshot.docs)
        .map((docs) => docs.map((e) => Food.fromJson(e.data())).toList());
  }

  Reference getImageRef(String path) {
    return storageRef.child(path);
  }
}
