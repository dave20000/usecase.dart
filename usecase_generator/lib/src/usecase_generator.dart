import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:usecase_annotation/usecase_annotation.dart';

import 'usecase_class_generator.dart';

class UseCaseGenerator extends GeneratorForAnnotation<UseCase> {
  final Map<String, dynamic> options;

  UseCaseGenerator(this.options);

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
      bool isInjectableDIGlobal = false;
      if (options["isInjectableDI"] != null && options["isInjectableDI"]) {
        isInjectableDIGlobal = true;
      }

      // final isInjectableDI =
      //     annotation.read('isInjectableDI').literalValue as bool;

      return UseCaseClassGenerator(
        (element).methods,
        (element).name,
        // isInjectableDI ? true : isInjectableDIGlobal,
        isInjectableDIGlobal,
      ).generate();
    }
  }
}
