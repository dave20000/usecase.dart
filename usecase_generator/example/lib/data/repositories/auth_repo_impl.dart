import '../../domain/models/account_type.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  void login(AccountType accountType) {}

  @override
  Future<bool> logout() async {
    return true;
  }

  @override
  Future<bool> create({required int x, required int y, required int z}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> create2(String abc, {required int x, required int y, int? z}) {
    throw UnimplementedError();
  }
}
