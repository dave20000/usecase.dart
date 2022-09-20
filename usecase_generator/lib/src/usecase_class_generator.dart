import 'package:analyzer/dart/element/element.dart';

import 'utils.dart';

class UseCaseClassGenerator {
  final StringBuffer _stringBuffer = StringBuffer();

  final List<MethodElement> methodList;
  final String repositoryClassName;
  final bool isInjectableDI;

  UseCaseClassGenerator(
    this.methodList,
    this.repositoryClassName,
    this.isInjectableDI,
  );

  String generate() {
    for (var method in methodList) {
      _generateUsecaseClassFromMethod(method);
    }
    return _stringBuffer.toString();
  }

  void _generateUsecaseClassFromMethod(MethodElement methodElement) {
    final methodName = methodElement.name;
    final methodClassName = '${toPascalCase(methodName)}UseCase';
    final repoParamsClassName = '${toPascalCase(methodName)}Params';

    if (!isInjectableDI) {
      _generateRiverpodDI(methodName, methodClassName);
    }
    _generateUseCaseClass(
      methodElement,
      methodName,
      methodClassName,
      repoParamsClassName,
    );

    final methodParameters = methodElement.parameters;
    final hasMethodParameters = methodParameters.isNotEmpty;

    if (hasMethodParameters) {
      _generateParamsClass(repoParamsClassName, methodParameters);
    }
  }

  void _generateRiverpodDI(String methodName, String methodClassName) {
    _stringBuffer.writeln(
      'final ${toLowerCamelCase(methodName)}UseCaseProvider = Provider(',
    );
    _stringBuffer.writeln(
      '  (ref) => $methodClassName(ref.read(${toLowerCamelCase(repositoryClassName)}Provider)),',
    );
    _stringBuffer.writeln(');');
  }

  void _generateUseCaseClass(
    MethodElement methodElement,
    String methodName,
    String methodClassName,
    String repoParamsClassName,
  ) {
    final repoClassNameParameter = "_${toLowerCamelCase(repositoryClassName)}";

    final methodParameters = methodElement.parameters;
    final hasMethodParameters = methodParameters.isNotEmpty;
    final methodReturnType =
        methodElement.returnType.getDisplayString(withNullability: false);
    final isMethodAsync = methodElement.returnType.isDartAsyncFuture;

    _stringBuffer.writeln('class $methodClassName {');
    _stringBuffer.writeln(
      'final $repositoryClassName $repoClassNameParameter;\n',
    );
    _stringBuffer.writeln(
      'const $methodClassName(this.$repoClassNameParameter);\n',
    );
    _stringBuffer.write(methodReturnType);
    _stringBuffer.write(' call(');
    if (hasMethodParameters) {
      _stringBuffer.write('$repoParamsClassName params');
    }
    _stringBuffer.write(') ');
    _stringBuffer.writeln(isMethodAsync ? 'async {' : '{');
    _stringBuffer.writeln('return $repoClassNameParameter.$methodName(');
    for (var parameter in methodParameters) {
      final parameterName = parameter.name;
      _stringBuffer.writeln('params.$parameterName,');
    }
    _stringBuffer.writeln(');');
    _stringBuffer.writeln('}');
    _stringBuffer.writeln('}\n');
  }

  void _generateParamsClass(
    String repoParamsClassName,
    List<ParameterElement> parameters,
  ) {
    _stringBuffer.writeln('class $repoParamsClassName {');
    for (var parameter in parameters) {
      final parameterName = parameter.name;
      final parameterReturnType =
          parameter.type.getDisplayString(withNullability: false);
      _stringBuffer.writeln('final $parameterReturnType $parameterName;\n');
    }
    _stringBuffer.writeln('const $repoParamsClassName ({');
    for (var parameter in parameters) {
      final parameterName = parameter.name;
      _stringBuffer.writeln('required this.$parameterName,');
    }
    _stringBuffer.writeln('});');
    _stringBuffer.writeln('}');
  }
}
