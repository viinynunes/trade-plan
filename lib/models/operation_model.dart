import 'package:hive_flutter/hive_flutter.dart';

part 'operation_model.g.dart';

@HiveType(typeId: 1)
class OperationModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double? defaultStopLoss;
  @HiveField(3)
  double? defaultExpectedTakeProfit;

  OperationModel({
    this.id,
    this.defaultStopLoss,
    this.defaultExpectedTakeProfit,
    required this.name,
  });
}
