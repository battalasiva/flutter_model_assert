class ValidationResult {
  final bool isValid;
  final List<String> errors;

  ValidationResult(this.isValid, this.errors);

  String prettyPrint() {
    if (isValid) return "✅ No contract violations found";
    return "🚨 API Contract Broken\n\n${errors.join('\n')}";
  }
}
