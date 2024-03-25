import 'package:health_tracker/models/user_information.dart';
import 'package:health_tracker/repository/user_information_repository.dart';

class ProfileController {
  final UserInformationRepository _userInformationRepository =
      UserInformationRepository();

  Future<UserInformation> getUserInformationByUserUid(String userId) async {
    return _userInformationRepository.getUserInformationByUserUid(userId);
  }

  Future<void> updateUserInformationByUserId(
      UserInformation userInformation) async {
    return _userInformationRepository
        .updateUserInformationByUserId(userInformation);
  }
}
