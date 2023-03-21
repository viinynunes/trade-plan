import 'package:hive_flutter/hive_flutter.dart';

part 'operation_model.g.dart';

@HiveType(typeId: 1)
class OperationModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;

  OperationModel({
    this.id,
    required this.name,
  });
}
