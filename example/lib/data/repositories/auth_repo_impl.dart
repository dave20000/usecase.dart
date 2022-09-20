import '../../domain/models/account_type.dart';
import '../../domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  void login(AccountType accountType) {}

  @override
  Future<bool> logout() async {
    return true;
  }
}
