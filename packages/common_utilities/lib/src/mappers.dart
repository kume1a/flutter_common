DateTime? tryMapDate(String? dateString) {
  return dateString != null ? DateTime.tryParse(dateString)?.toLocal() : null;
}

MODEL? tryMap<MODEL, SCHEMA>(SCHEMA? schema, MODEL Function(SCHEMA schema) mapper) {
  return schema != null ? mapper(schema) : null;
}

Future<MODEL?> tryMapAsync<MODEL, SCHEMA>(
  SCHEMA? schema,
  Future<MODEL> Function(SCHEMA schema) mapper,
) {
  return schema != null ? mapper(schema) : Future<MODEL>.value();
}

List<MODEL>? tryMapList<MODEL, SCHEMA>(
  List<SCHEMA>? schema,
  MODEL Function(SCHEMA schema) mapper,
) {
  return schema != null && schema.isNotEmpty ? schema.map(mapper).toList() : null;
}

Future<List<MODEL>> mapListOrEmptyAsync<MODEL, SCHEMA>(
  List<SCHEMA>? schema,
  Future<MODEL> Function(SCHEMA schema) mapper,
) {
  return schema != null && schema.isNotEmpty
      ? Future.wait(schema.map(mapper).toList())
      : Future<List<MODEL>>.value(<MODEL>[]);
}

List<MODEL> mapListOrEmpty<MODEL, SCHEMA>(
  List<SCHEMA>? schema,
  MODEL Function(SCHEMA schema) mapper,
) {
  return tryMapList(schema, mapper) ?? <MODEL>[];
}

MODEL? tryMapOptional<MODEL, SCHEMA>(SCHEMA? schema, MODEL? Function(SCHEMA? schema) mapper) {
  return schema != null ? mapper(schema) : null;
}
