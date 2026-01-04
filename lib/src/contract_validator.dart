import 'package:flutter_model_assert/src/model_descriptor.dart';

class ContractValidator {
  static List<String> validateContract(
    Map<String, dynamic> json,
    ModelDescriptor descriptor,
  ) {
    List<String> errors = [];

    descriptor.fields.forEach((key, type) {
      if (json.containsKey(key)) {
        if (json[key].runtimeType != type) {
          errors.add(
            "Field '$key' expected $type but got ${json[key].runtimeType}",
          );
        }
      }
    });

    descriptor.nested?.forEach((key, nestedDescriptor) {
      if (json[key] is Map<String, dynamic>) {
        errors.addAll(validateContract(json[key], nestedDescriptor));
      }
    });

    return errors;
  }
}
