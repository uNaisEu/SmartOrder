import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/login_entity.dart';
import '../entities/user_entity.dart';


abstract interface class LoginRepository {
  Future<Either<Failure, UserEntity>> login({
    required LoginEntity login
  });
}
