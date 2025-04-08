import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/constants_text.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';
import '../models/login_response_model.dart';


class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  LoginRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginEntity login
  }) {
    return _login(
      () async => await remoteDataSource.login(
        login: login.toModel()
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _login(
    Future<LoginResponseModel> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(ConstantsText.noConnectionErrorMessage));
      }
      final response = await fn();
      UserEntity user = response.toEntity();
      
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}