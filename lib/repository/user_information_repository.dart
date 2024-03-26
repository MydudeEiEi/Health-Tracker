import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_tracker/models/user_information.dart';

class UserInformationRepository {
  CollectionReference<Map<String, dynamic>> nutritionCollections =
      FirebaseFirestore.instance.collection('userInformation');

  Future<UserInformation> getUserInformationByUserUid(String userId) async {
    final doc =
        await nutritionCollections.where('user_id', isEqualTo: userId).get();
    final data =
        doc.docs.map((e) => UserInformation.fromJson(e.data())).toList();
    if (data.isEmpty) {
      final newUserInfo = UserInformation.empty(userId: userId);
      await addUserInformation(newUserInfo);
      return newUserInfo;
    }
    return data[0];
  }

  Future<void> addUserInformation(UserInformation userInformation) async {
    await nutritionCollections.add(userInformation.toJson());
  }

  Future<void> updateUserInformationByUserId(
      UserInformation userInformation) async {
    final doc = await nutritionCollections
        .where('user_id', isEqualTo: userInformation.userId)
        .get();
    if (doc.docs.isEmpty) {
      print('update user information failed because data is empty');
      return;
    }
    final id = doc.docs[0].id;
    await nutritionCollections.doc(id).update(userInformation.toJson());
  }
}
