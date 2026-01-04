class ModelDescriptor {
  final Map<String, Type> fields;
  final Map<String, ModelDescriptor>? nested;

  ModelDescriptor({required this.fields, this.nested});
}
