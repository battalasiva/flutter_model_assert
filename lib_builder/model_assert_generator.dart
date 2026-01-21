import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:flutter_model_assert/annotations/model_assert.dart';
import 'type_extractor.dart';

class ModelAssertGenerator extends GeneratorForAnnotation<ModelAssert> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final classElement = element as ClassElement;
    final className = classElement.name;

    final extractor = TypeExtractor();
    final fields = extractor.extract(classElement);

    final buffer = StringBuffer();

    buffer.writeln('''
void _register${className}Contract() {
  ContractRegistry.register<$className>({
''');

    fields.forEach((k, v) {
      buffer.writeln("  '$k': '$v',");
    });

    buffer.writeln('});');
    buffer.writeln('}');

    return buffer.toString();
  }
}
