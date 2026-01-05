export 'src/model_descriptor.dart' show ModelDescriptor;

class FlutterModelAssert {
  /// Detects type mismatches early and prints exact error-causing fields.
  /// Developer calls this only when debugging a specific API response.
  static void detect<T>(Map<String, dynamic> json) {
    try {
      // Create a sample empty model instance from developer's model
      final model = _createEmptyModel<T>();
      final modelJson = (model as dynamic).toJson() as Map<String, dynamic>;

      final errors = <String>[];

      void walk(
        Map<String, dynamic> expectedMap,
        Map<String, dynamic> receivedMap, [
        String parent = "",
      ]) {
        expectedMap.forEach((key, expectedValue) {
          final fieldPath = parent.isEmpty ? key : "$parent.$key";
          final receivedValue = receivedMap[key];

          final expectedType = expectedValue?.runtimeType;
          final receivedType = receivedValue?.runtimeType;

          if (receivedValue == null) {
            if (_isNullableTypeFromString(expectedValue)) {
              return; // nullable allowed
            }
            errors.add(
              "⚠️ Key '$fieldPath' is missing or null in backend response.",
            );
            return;
          }

          if (expectedType != receivedType) {
            errors.add(
              "❗ Type mismatch at '$fieldPath'\n"
              "  → Expected: $expectedType\n"
              "  ← Received: $receivedType  (value: $receivedValue)\n",
            );
          }

          // Nested object validation
          if (expectedValue is Map<String, dynamic> &&
              receivedValue is Map<String, dynamic>) {
            walk(expectedValue, receivedValue, fieldPath);
          }
        });
      }

      walk(modelJson, json);

      if (errors.isNotEmpty) {
        print(
          "\n🚨 FlutterModelAssert Report for model: $T\n${errors.join('\n')}",
        );
      } else {
        print("\n✅ No contract mismatches found for model: $T");
      }
    } catch (e) {
      print(
        "🚨 FlutterModelAssert detection failed.\nMake sure your model has:\n"
        "  ✔ factory Model.empty()\n"
        "  ✔ Map<String, dynamic> toJson()\nError: $e",
      );
    }
  }

  /// Helper to check null safety based on field type name string
  static bool _isNullableTypeFromString(dynamic value) {
    if (value == null) return true;
    return value.runtimeType.toString().contains('?');
  }

  /// Creates model.empty() instance (developer must add empty() factory)
  static T _createEmptyModel<T>() {
    return (T as dynamic).empty();
  }
}
