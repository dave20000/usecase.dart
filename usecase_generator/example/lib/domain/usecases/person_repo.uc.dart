// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../repositories/person_repo.dart';

// **************************************************************************
// UseCaseGenerator
// **************************************************************************

final getUserUseCaseProvider = Provider(
  (ref) => GetUserUseCase(ref.read(personRepoProvider)),
);

class GetUserUseCase {
  final PersonRepo _personRepo;

  const GetUserUseCase(this._personRepo);

  void call() {
    return _personRepo.getUser();
  }
}

final getPersonDetailUseCaseProvider = Provider(
  (ref) => GetPersonDetailUseCase(ref.read(personRepoProvider)),
);

class GetPersonDetailUseCase {
  final PersonRepo _personRepo;

  const GetPersonDetailUseCase(this._personRepo);

  Future<void> call(GetPersonDetailParams params) async {
    return _personRepo.getPersonDetail(
      params.id,
      name: params.name,
    );
  }
}

class GetPersonDetailParams {
  final int id;

  final String name;

  const GetPersonDetailParams(
    this.id, {
    required this.name,
  });
}
