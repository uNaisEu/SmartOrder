import '../../../core/error/failures.dart';
import '../domain/entities/user_entity.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuthenticated extends LoginState {
  final UserEntity user;
  LoginAuthenticated(this.user);
}

class LoginUnauthenticated extends LoginState {}

class LoginFailure extends LoginState {
  final Failure failure;
  LoginFailure(this.failure);
}
