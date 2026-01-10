library flutter_model_assert;

import 'package:flutter_model_assert/runtime/validation_result.dart';
import 'package:flutter_model_assert/runtime/validator.dart';

export 'annotations/model_assert.dart';
export 'runtime/validator.dart';
export 'runtime/validation_result.dart';

class FlutterModelAssert {
  static ValidationResult validate<T>(Map<String, dynamic> json) {
    return ContractValidator.validate<T>(json);
  }
}
