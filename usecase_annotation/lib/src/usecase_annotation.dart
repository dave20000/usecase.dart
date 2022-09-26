/// Annotate your repo class with `@UseCase()` or `@useCase`
/// to generate usecase classes for each functions
///
/// **NOTE**: The repository class must be `abstract`!
///
/// ```dart
/// @UseCase()
/// abstract class AuthRepository {
///   void m1();
///   Future<String> m2(int param1);
/// }
///
/// class AuthRepositoryImpl implements AuthRepository {
///   // Concrete implementation
/// }
/// ```
/// The example above will generate theses classes,
/// - `M1UseCase`, which calls `authRepository.m1()`
/// - `M2UseCase`, which calls `authRepository.m2()`
///
class UseCase {
  const UseCase();
}

const useCase = UseCase();
