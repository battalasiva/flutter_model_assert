class FlutterModelAssert {
  /// One-line debugging API to detect backend type regressions safely
  static ValidationResult detect<T>(
    Map<String, dynamic> json, {
    dynamic sample,
  }) {
    final errors = <String>[];

    void walk(dynamic expected, dynamic received, String path) {
      if (received == null) return;

      // Nullable fields allowed
      if (expected == null) return;

      final expType = expected.runtimeType;
      final recType = received.runtimeType;

      if (expType != recType) {
        errors.add(
          "❗ Type mismatch at '$path'\n"
          "  → Expected: $expType\n"
          "  ← Received: $recType (value: $received)\n",
        );
      }

      if (expected is Map && received is Map) {
        expected.forEach((k, v) {
          walk(v, received[k], path.isEmpty ? k : "$path.$k");
        });
      }

      if (expected is List && received is List) {
        for (int i = 0; i < expected.length; i++) {
          walk(expected[i], received[i], "$path[$i]");
        }
      }
    }

    if (sample != null) {
      final expectedJson = (sample as dynamic).toJson() as Map<String, dynamic>;
      walk(expectedJson, json, T.toString());
    }

    if (errors.isNotEmpty) {
      return ValidationResult.error(errors.join("\n"));
    }
    return ValidationResult.success();
  }
}

/// Result returned from model contract inspection
class ValidationResult {
  final bool isValid;
  final String? errorReport;

  ValidationResult._(this.isValid, this.errorReport);

  factory ValidationResult.success() => ValidationResult._(true, null);

  factory ValidationResult.error(String error) =>
      ValidationResult._(false, error);
}
