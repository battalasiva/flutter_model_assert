class FlutterModelAssert {
  /// Detect mismatches using a sample model instance
  static void detectModel<T>(
    Map<String, dynamic> json, {
    required dynamic sample,
  }) {
    try {
      final expectedJson = sample.toJson() as Map<String, dynamic>;
      final errors = <String>[];

      void validate(
        Map<String, dynamic> exp,
        Map<String, dynamic> rec,
        String path,
      ) {
        exp.forEach((key, value) {
          final currentPath = path.isEmpty ? key : "$path.$key";
          final recVal = rec[key];

          if (recVal == null) return;

          if (value != null && recVal.runtimeType != value.runtimeType) {
            errors.add(
              "❗ Field: '$currentPath'\n"
              "➡ Expected: ${value.runtimeType}\n"
              "⬅ Received: ${recVal.runtimeType}  (value: $recVal)\n",
            );
          }

          if (value is Map && recVal is Map) {
            validate(
              value.cast<String, dynamic>(),
              recVal.cast<String, dynamic>(),
              currentPath,
            );
          }
        });
      }

      validate(expectedJson, json, "");

      if (errors.isNotEmpty) {
        print(
          "\n🚨 FlutterModelAssert Mismatch Report for: $T\n${errors.join('\n')}",
        );
      } else {
        print("\n✅ No mismatches found for model: $T");
      }
    } catch (e) {
      print("🚨 FlutterModelAssert inspection failed: $e");
    }
  }
}
