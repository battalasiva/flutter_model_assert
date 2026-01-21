import 'package:analyzer/dart/element/element.dart';

class TypeExtractor {
  Map<String, String> extract(ClassElement element, [String prefix = '']) {
    final map = <String, String>{};

    for (final field in element.fields) {
      if (field.isStatic) continue;

      final name = prefix.isEmpty ? field.name : '$prefix.${field.name}';
      final type = field.type.getDisplayString(withNullability: true);

      map[name] = type;

      final fieldType = field.type.element;
      if (fieldType is ClassElement && !_isCore(fieldType.name)) {
        map.addAll(extract(fieldType, name));
      }
    }
    return map;
  }

  bool _isCore(String name) {
    const core = {
      'String',
      'int',
      'double',
      'bool',
      'num',
      'Object',
      'List',
      'Map',
      'DateTime',
      'dynamic',
    };
    return core.contains(name);
  }
}
