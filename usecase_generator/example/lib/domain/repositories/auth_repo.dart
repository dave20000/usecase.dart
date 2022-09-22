import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usecase_annotation/usecase_annotation.dart';

import '../../data/repositories/auth_repo_impl.dart';
import '../models/account_type.dart';

part '../usecases/auth_repo.uc.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepoImpl());

@UseCase()
abstract class AuthRepo {
  void login(AccountType accountType);
  Future<bool> logout();
  Future<bool> create({required int x, required int y, required int z});
  Future<bool> create2(String abc, {required int x, required int y, int? z});
}
