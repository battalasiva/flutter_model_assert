import 'package:flutter_model_assert/flutter_model_assert.dart';
import 'package:flutter_model_assert/src/model_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Detects int changed to double', () {
    final json = {"count": 5};

    final schema = ModelDescriptor(fields: {"count": int});

    final result = FlutterModelAssert.validateWithSchema(
      json,
      schema,
      requiredKeys: ["count"],
    );

    expect(result.isValid, false);
    expect(result.errorReport?.contains("count"), true);
  });
}
