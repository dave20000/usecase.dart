import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usecase_annotation/usecase_annotation.dart';

import '../../data/repositories/person_repo_impl.dart';

part '../usecases/person_repo.uc.dart';

final personRepoProvider = Provider<PersonRepo>((ref) => PersonRepoImpl());

@useCase
abstract class PersonRepo {
  void getUser();
  Future<void> getPersonDetail(int id, {required String name});
}
