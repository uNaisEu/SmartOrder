import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/stub_user_model.dart';

class LoginApi {
  final Dio _dio = Dio();
  final String _remoteJsonUrl = 'https://storage.yandexcloud.net/mobile-dev/SmartOrder/jsons/users.json';

  Future<LoginResponseModel> login(LoginRequestModel login) async {
    try {
      final response = await _dio.get(_remoteJsonUrl);

      if (response.statusCode == 200) {
        final List<dynamic> usersJson = response.data;
        final users = usersJson.map((json) => StubUserModel.fromJson(json)).toList();

        for (var user in users) {
          if (user.username == login.username && user.password == login.password) {
            return LoginResponseModel(
              message: "OK 200",
              moodleToken: user.moodleToken,
              userInfo: user.userInfo,
            );
          }
        }

        throw Exception("Неверные учетные данные");
      } else {
        throw Exception("Ошибка загрузки данных: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Ошибка: $e");
      throw Exception("Не удалось авторизоваться. Проверьте соединение.");
    }
  }
}
