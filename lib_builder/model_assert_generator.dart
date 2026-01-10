import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter_model_assert/annotations/model_assert.dart';
import 'type_extractor.dart';

class ModelAssertGenerator extends GeneratorForAnnotation<ModelAssert> {
  @override
  String generateForAnnotatedElement(
    element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final className = element.displayName;
    final extractor = TypeExtractor();
    final contract = extractor.extract(element as ClassElement);

    return '''
ContractRegistry.register<$className>({
${contract.entries.map((e) => "'${e.key}': '${e.value}'").join(',\n')}
});
''';
  }
}
