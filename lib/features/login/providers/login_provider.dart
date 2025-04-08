import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../../core/storage/user_storage_service.dart';
import '../domain/entities/login_entity.dart';
import '../domain/usecases/login_usecase.dart';
import 'login_state.dart';


class LoginProvider {
  final LoginUseCase _getLoginUseCase;
  final UserStorageService _storage;
  final _stateController = BehaviorSubject<LoginState>.seeded(LoginInitial());

  LoginProvider({
    required LoginUseCase getLoginUseCase, 
    required UserStorageService storage
  }) : _getLoginUseCase = getLoginUseCase, 
       _storage = storage {
    _stateController.add(LoginInitial());
    _initialize();
  }

  Stream<LoginState> get state => _stateController.stream;

  Future<void> _initialize() async {
    _stateController.add(LoginLoading());

    final user = await _storage.getUser();
    if (user != null && user.moodleToken.isNotEmpty) {
      _stateController.add(LoginAuthenticated(user));
    } else {
      _stateController.add(LoginUnauthenticated());
    }
  }

  Future<void> login(LoginEntity login) async {
    _stateController.add(LoginLoading());

    final result = await _getLoginUseCase.call(login);
    result.fold(
      (failure) => _stateController.add(LoginFailure(failure)),
      (user) async {
        await _storage.setUser(user);
        _stateController.add(LoginAuthenticated(user));
      },
    );
  }

  Future<void> logout() async {
    await _storage.clear();
    _stateController.add(LoginUnauthenticated());
  }
}
