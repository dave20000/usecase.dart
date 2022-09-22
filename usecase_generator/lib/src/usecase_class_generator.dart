import 'package:analyzer/dart/element/element.dart';

class UseCaseClassGenerator {
  final StringBuffer _stringBuffer = StringBuffer();

  final List<MethodElement> methodList;
  final String repositoryClassName;
  final bool isInjectableDI;

  UseCaseClassGenerator(
    this.methodList,
    this.repositoryClassName,
    this.isInjectableDI,
  ) {
    _toPascalCase(repositoryClassName);
  }

  String generate() {
    for (var method in methodList) {
      _generateUsecaseClassFromMethod(method);
    }
    return _stringBuffer.toString();
  }

  void _generateUsecaseClassFromMethod(MethodElement methodElement) {
    final methodName = methodElement.name;
    final methodClassName = '${_toPascalCase(methodName)}UseCase';
    final repoParamsClassName = '${_toPascalCase(methodName)}Params';

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
      'final ${_toLowerCamelCase(methodName)}UseCaseProvider = Provider(',
    );
    _stringBuffer.writeln(
      '  (ref) => $methodClassName(ref.read(${_toLowerCamelCase(repositoryClassName)}Provider)),',
    );
    _stringBuffer.writeln(');');
  }

  void _generateUseCaseClass(
    MethodElement methodElement,
    String methodName,
    String methodClassName,
    String repoParamsClassName,
  ) {
    final repoClassNameParameter = "_${_toLowerCamelCase(repositoryClassName)}";

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
      _stringBuffer.writeln(
        parameter.isRequiredNamed || parameter.isOptionalNamed
            ? '$parameterName : params.$parameterName,'
            : 'params.$parameterName,',
      );
    }
    _stringBuffer.writeln(');');
    _stringBuffer.writeln('}');
    _stringBuffer.writeln('}\n');
  }

  void _generateParamsClass(
    String repoParamsClassName,
    List<ParameterElement> methodParameters,
  ) {
    _stringBuffer.writeln('class $repoParamsClassName {');
    bool isAnyParamNotFinal = false;
    for (var parameter in methodParameters) {
      final parameterName = parameter.name;
      final isOptional = parameter.isOptional;
      final parameterReturnType = parameter.type.getDisplayString(
        withNullability: isOptional,
      );
      isAnyParamNotFinal =
          isAnyParamNotFinal == true ? isAnyParamNotFinal : isOptional;

      _stringBuffer.writeln(
        isOptional
            ? '$parameterReturnType $parameterName;\n'
            : 'final $parameterReturnType $parameterName;\n',
      );
    }
    _stringBuffer.writeln(
      isAnyParamNotFinal
          ? '$repoParamsClassName ('
          : 'const $repoParamsClassName (',
    );
    bool firstNamedParam = true;
    for (int i = 0; i < methodParameters.length; i++) {
      final parameter = methodParameters[i];
      final parameterName = parameter.name;

      if (!parameter.isNamed) {
        _stringBuffer.writeln('this.$parameterName,');
      } else {
        firstNamedParam = firstNamedParam == true ? firstNamedParam : false;
        if (firstNamedParam == true) {
          _stringBuffer.write('{');
        }
        _stringBuffer.writeln(
          !parameter.isRequiredNamed
              ? 'this.$parameterName,'
              : 'required this.$parameterName,',
        );
        firstNamedParam = false;
      }
      if (i == methodParameters.length - 1) {
        _stringBuffer.writeln(!parameter.isNamed ? ');' : '});');
      }
    }

    _stringBuffer.writeln('}');
  }

  /// Convert [String] with first character lower case
  String _toLowerCamelCase(String s) {
    if (s.length < 2) return s.toLowerCase();
    return s[0].toLowerCase() + s.substring(1);
  }

  /// Convert [String] with first character upper case
  String _toPascalCase(String s) {
    if (s.length < 2) return s.toUpperCase();
    return s[0].toUpperCase() + s.substring(1);
  }
}
