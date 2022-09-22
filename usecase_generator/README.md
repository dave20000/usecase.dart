# UseCase Generator

usecase_generator is generator package for usecase_annotation for generating usecases class from the repository class

Requires usecase_annotation package to annotate class.

## Add the package

Add the [`usecase_annotation`](https://pub.dev/packages/usecase_annotation) package as a dependencies and the `usecase_generator` package as a dev_dependencies as well as the `build_runner` package in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  usecase_annotation: latest

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: any
  usecase_generator: latest
```

## Quick tutorial

Create a auth_repo.dart class file and Annotate your repo class with `@useCase` or `@UseCase()` to generate usecase classes for each functions:

**NOTE**: The repository class must be `abstract`!

```dart
@UseCase()
abstract class AuthRepository {
    void m1();
    Future<String> m2(int param1);
}

class AuthRepositoryImpl implements AuthRepository {
 // Concrete implementation
}
```

Run the build command:

```shell
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This will generate theses classes in auth_repo.uc.dart file =>
`M1UseCase`, which calls `authRepository.m1()`
`M2UseCase`, which calls `authRepository.m2()`

## Important

To have all the usecases files in same folder you need to create a `build.yaml` file next to `pubspec.yaml` file.
In this file you need to add the below content:

```yaml
targets:
    $default:
        builders:
            usecase_generator|usecase_gen:
                options:
                    build_extensions:
                        {
                            "^lib/domain/repositories/{{}}.dart": "lib/domain/usecases/{{}}.uc.dart",
                        }
```

You can update key and value pair according to your requirements

## Motivation

This package is build to follow Uncle bob clean architecture approach and create usecases classes for your repository classes.

---

## Riverpod DI

The package is build to support riverpod dependency injection. You need to add [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) package to your `pubspec.yaml` file.

By default this package comes with riverpod dependency injection to turn off riverpod di you need to make `isInjectableDI` parameter of UseCase annotation to true.

## Injectable DI

This package can also work with the [`injectable`](https://pub.dev/packages/injectable) package.

Firstly you need to make `isInjectableDI` as true.

Then as all the usecases class ends with the `-UseCase` so you just need to create a `build.yaml` file next to `pubspec.yaml` file and In this file you need to add the below content:

```yaml
targets:
  $default:
    builders:
      injectable_generator:injectable_builder:
        options:
          auto_register: true
          class_name_pattern: "UseCase$"
```

---
