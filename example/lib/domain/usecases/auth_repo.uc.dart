// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../repositories/auth_repo.dart';

// **************************************************************************
// UseCaseGenerator
// **************************************************************************

class LoginUseCase {
  final AuthRepo _authRepo;

  const LoginUseCase(this._authRepo);

  void call(LoginParams params) {
    return _authRepo.login(
      params.accountType,
    );
  }
}

final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(ref.read(authRepoProvider)),
);

class LoginParams {
  final AccountType accountType;

  const LoginParams({
    required this.accountType,
  });
}

class LogoutUseCase {
  final AuthRepo _authRepo;

  const LogoutUseCase(this._authRepo);

  Future<bool> call() async {
    return _authRepo.logout();
  }
}

final logoutUseCaseProvider = Provider(
  (ref) => LogoutUseCase(ref.read(authRepoProvider)),
);
