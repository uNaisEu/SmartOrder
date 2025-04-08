import '../../domain/entities/user_entity.dart';
import 'user_model.dart';


class LoginResponseModel {
  final String message;
  final String moodleToken;
  final UserModel userInfo;

  LoginResponseModel({
    required this.message,
    required this.moodleToken,
    required this.userInfo,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      moodleToken: json['moodle_token'],
      userInfo: UserModel.fromJson(json['user_info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'moodle_token': moodleToken,
      'user_info': userInfo.toJson(),
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: userInfo.id,
      name: userInfo.fullName,
      image: userInfo.profilePic,
      moodleToken: moodleToken,
    );
  }
}