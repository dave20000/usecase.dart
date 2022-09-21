abstract class AuthRepo {
  void m1();
  Future<String> m2(int param1);
}

class AuthRepoImpl implements AuthRepo {
  @override
  void m1() {}

  @override
  Future<String> m2(int param1) {
    throw UnimplementedError();
  }
}
