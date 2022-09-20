import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/usecase_generator.dart';

Builder useCaseGenerator(BuilderOptions options) => PartBuilder(
      [UseCaseGenerator()],
      '.uc.dart',
      header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
    ''',
      options: options,
    );
