import '../../data/models/login_request_model.dart';

class LoginEntity {
  final String username;
  final String password;

  LoginEntity({
    required this.username,
    required this.password,
  });

  LoginRequestModel toModel() {
    return LoginRequestModel(
      username: username,
      password: password,
    );
  }
}