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
    if (descriptor == null) {
      return ValidationResult.error("Schema not defined for model validation");
    }

    for (var key in requiredKeys) {
      if (!json.containsKey(key)) {
        return ValidationResult.error("Missing required key: $key");
      }
    }

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
