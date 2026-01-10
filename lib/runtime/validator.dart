import '../generated/contract_registry.dart';
import 'validation_result.dart';
import 'type_utils.dart';

class ContractValidator {
  static ValidationResult validate<T>(Map<String, dynamic> json) {
    final contract = ContractRegistry.get<T>();
    if (contract == null) {
      return ValidationResult(true, []);
    }

    final errors = <String>[];

    void walk(Map<String, dynamic> node, String path) {
      node.forEach((key, value) {
        final currentPath = path.isEmpty ? key : '$path.$key';
        final expected = contract[currentPath];

        if (expected != null && !isCompatible(expected, value)) {
          errors.add(
            "❗ $currentPath\n"
            "   Expected: $expected\n"
            "   Received: ${value.runtimeType} ($value)\n",
          );
        }

        if (value is Map<String, dynamic>) {
          walk(value, currentPath);
        }

        if (value is List) {
          for (int i = 0; i < value.length; i++) {
            if (value[i] is Map<String, dynamic>) {
              walk(value[i], '$currentPath[$i]');
            }
          }
        }
      });
    }

    walk(json, '');

    return ValidationResult(errors.isEmpty, errors);
  }
}
