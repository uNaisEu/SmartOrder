import '../../../../core/error/exceptions.dart';
import '../api/login_api.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';


abstract interface class LoginRemoteDataSource {  
  Future<LoginResponseModel> login({
    required LoginRequestModel login
  });
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final LoginApi api;

  LoginRemoteDataSourceImpl(this.api);

  @override
  Future<LoginResponseModel> login({
    required LoginRequestModel login
  }) async {
    try {
      LoginResponseModel response = await api.login(login);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}