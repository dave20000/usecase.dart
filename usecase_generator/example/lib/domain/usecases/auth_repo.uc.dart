// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../repositories/auth_repo.dart';

// **************************************************************************
// UseCaseGenerator
// **************************************************************************

final loginUseCaseProvider = Provider(
  (ref) => LoginUseCase(ref.read(authRepoProvider)),
);

class LoginUseCase {
  final AuthRepo _authRepo;

  const LoginUseCase(this._authRepo);

  void call(LoginParams params) {
    return _authRepo.login(
      params.accountType,
    );
  }
}

class LoginParams {
  final AccountType accountType;

  const LoginParams(
    this.accountType,
  );
}

final logoutUseCaseProvider = Provider(
  (ref) => LogoutUseCase(ref.read(authRepoProvider)),
);

class LogoutUseCase {
  final AuthRepo _authRepo;

  const LogoutUseCase(this._authRepo);

  Future<bool> call() async {
    return _authRepo.logout();
  }
}

final createUseCaseProvider = Provider(
  (ref) => CreateUseCase(ref.read(authRepoProvider)),
);

class CreateUseCase {
  final AuthRepo _authRepo;

  const CreateUseCase(this._authRepo);

  Future<bool> call(CreateParams params) async {
    return _authRepo.create(
      x: params.x,
      y: params.y,
      z: params.z,
    );
  }
}

class CreateParams {
  final int x;

  final int y;

  final int z;

  const CreateParams({
    required this.x,
    required this.y,
    required this.z,
  });
}

final create2UseCaseProvider = Provider(
  (ref) => Create2UseCase(ref.read(authRepoProvider)),
);

class Create2UseCase {
  final AuthRepo _authRepo;

  const Create2UseCase(this._authRepo);

  Future<bool> call(Create2Params params) async {
    return _authRepo.create2(
      params.abc,
      x: params.x,
      y: params.y,
      z: params.z,
    );
  }
}

class Create2Params {
  final String abc;

  final int x;

  final int y;

  int? z;

  Create2Params(
    this.abc, {
    required this.x,
    required this.y,
    this.z,
  });
}
