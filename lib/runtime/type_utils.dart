bool isCompatible(String expected, dynamic value) {
  if (value == null) return true;

  switch (expected) {
    case 'int?':
    case 'int':
      return value is int;
    case 'double?':
    case 'double':
      return value is double || value is int;
    case 'String?':
    case 'String':
      return value is String;
    case 'bool?':
    case 'bool':
      return value is bool;
    default:
      return true;
  }
}
