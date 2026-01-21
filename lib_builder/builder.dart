import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'model_assert_generator.dart';

Builder modelAssertBuilder(BuilderOptions options) =>
    SharedPartBuilder([ModelAssertGenerator()], 'flutter_model_assert');
