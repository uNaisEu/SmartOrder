import 'dart:convert';

import '../../features/login/data/models/login_response_model.dart';
import '../../features/login/domain/entities/user_entity.dart';
import 'shared_preferences_async.dart';

class UserStorageService {
  static const _userKey = 'user';
  
  Future<void> setUser(UserEntity? user) async {
    final prefs = SharedPreferencesAsync.instance;

    if (user != null) {
      await prefs.setString(
        _userKey, 
        jsonEncode(user.toLoginResponseModel())
      );
    } else {
      await prefs.remove(_userKey);
    }
  }

  Future<UserEntity?> getUser() async {
    final prefs = SharedPreferencesAsync.instance;
    
    final loginResponseModelString = prefs.getString(_userKey);
    if (loginResponseModelString != null) {
      final result = LoginResponseModel.fromJson(
          jsonDecode(loginResponseModelString) as Map<String, dynamic>
      );
      return result.toEntity();
    }
    return null;
  }

  Future<void> clear() async {
    final prefs = SharedPreferencesAsync.instance;
    await prefs.remove(_userKey);
  }
}