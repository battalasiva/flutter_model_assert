import 'package:analyzer/dart/element/element.dart';

class TypeExtractor {
  Map<String, String> extract(ClassElement element, [String prefix = '']) {
    final map = <String, String>{};

    for (final field in element.fields) {
      if (field.isStatic) continue;

      final name = prefix.isEmpty ? field.name : '$prefix.${field.name}';
      final type = field.type.getDisplayString(withNullability: true);

      map[name] = type;

      if (field.type.element is ClassElement &&
          !field.type.isDartCoreList &&
          !field.type.isDartCoreMap &&
          !field.type.isDartCoreObject) {
        map.addAll(extract(field.type.element as ClassElement, name));
      }
    }
    return map;
  }
}
