import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/usecase_generator.dart';

/// Builds generators for `build_runner` to run
Builder useCaseGenerator(BuilderOptions options) => PartBuilder(
      [UseCaseGenerator(options.config)],
      '.uc.dart',
      header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
    ''',
      options: options,
    );
