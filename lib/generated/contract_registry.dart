class ContractRegistry {
  static final Map<Type, Map<String, String>> _contracts = {};

  static void register<T>(Map<String, String> contract) {
    _contracts[T] = contract;
  }

  static Map<String, String>? get<T>() => _contracts[T];
}
