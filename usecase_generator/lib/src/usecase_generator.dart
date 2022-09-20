import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:usecase_annotation/usecase_annotation.dart';

import 'usecase_class_generator.dart';
import 'utils.dart';

class UseCaseGenerator extends GeneratorForAnnotation<UseCase> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement) {
      // Throw if annotation is used for a other then class element
      throw InvalidGenerationSourceError(
        'usecase_gen: ${element.name} is not a class',
        todo: 'Have a class name same as element name',
        element: element,
      );
    } else if (!(element).isAbstract) {
      // Throw if annotation is used for an non abstract class
      throw InvalidGenerationSourceError(
        'usecase_gen: ${element.name} is not an abstract class',
        todo: 'Make repository class as abstract class',
        element: element,
      );
    } else if ((element).methods.isEmpty) {
      return '';
    } else {
      return UseCaseClassGenerator(
              (element).methods, toPascalCase((element).name))
          .generate();
    }
  }
}
