import 'dart:async';

abstract class BaseMapper<Schema, Model> {
  FutureOr<Model> mapToModel(Schema s) {
    throw UnimplementedError();
  }

  FutureOr<Schema> mapToSchema(Model m) {
    throw UnimplementedError();
  }
}
