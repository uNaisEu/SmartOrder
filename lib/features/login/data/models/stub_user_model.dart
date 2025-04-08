import 'user_model.dart';

class StubUserModel {
  final int userId;
  final String username;
  final String password;
  final String moodleToken;
  final UserModel userInfo;

  StubUserModel({
    required this.userId,
    required this.username,
    required this.password,
    required this.moodleToken,
    required this.userInfo,
  });

  factory StubUserModel.fromJson(Map<String, dynamic> json) {
    return StubUserModel(
      userId: json['user_id'],
      username: json['username'],
      password: json['password'],
      moodleToken: json['moodle_token'],
      userInfo: UserModel.fromJson(json['user_info'])
    );
  }
}