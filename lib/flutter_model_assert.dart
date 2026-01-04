import 'src/model_descriptor.dart';
import 'src/contract_validator.dart';

export 'src/model_descriptor.dart';
export 'src/contract_validator.dart';

class FlutterModelAssert {
  static ValidationResult validateWithSchema(
    Map<String, dynamic> json,
    ModelDescriptor descriptor, {
    required List<String> requiredKeys,
  }) {
    // Removed unnecessary null check for descriptor

    // Validate required keys
    final missing = <String>[];
    for (var key in requiredKeys) {
      if (!json.containsKey(key)) {
        missing.add(key);
      }
    }
    if (missing.isNotEmpty) {
      return ValidationResult.error(
        "Missing required key(s): ${missing.join(', ')}",
      );
    }

    // Validate schema contract
    final errors = ContractValidator.validateContract(json, descriptor);
    if (errors.isNotEmpty) {
      return ValidationResult.error(errors.join("\n"));
    }

    return ValidationResult.success();
  }
}

class ValidationResult {
  final bool isValid;
  final String? errorReport;

  ValidationResult._(this.isValid, this.errorReport);

  factory ValidationResult.success() => ValidationResult._(true, null);
  factory ValidationResult.error(String error) =>
      ValidationResult._(false, error);
}
