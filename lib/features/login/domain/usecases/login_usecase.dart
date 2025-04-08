import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repository.dart';
import '../entities/user_entity.dart';


class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(LoginEntity login) async {
    return await repository.login(login: login);
  }
}
