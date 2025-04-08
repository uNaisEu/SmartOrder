import '../../data/models/login_response_model.dart';
import '../../data/models/user_model.dart';

class UserEntity {
  final int id;
  final String name;
  final String image;
  final String moodleToken;

  UserEntity({
    required this.id,
    required this.name, 
    required this.image,
    required this.moodleToken,
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      fullName: name,
      profilePic: image,
    );
  }

  LoginResponseModel toLoginResponseModel() {
    return LoginResponseModel(
      message: "",
      moodleToken: moodleToken,
      userInfo: UserModel(
        id: id,
        fullName: name,
        profilePic: image,
      ),
    );
  }
}