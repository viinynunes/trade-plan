import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/models/enums/order_status_enum.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/models/paper_model.dart';

part 'order_model.g.dart';

@HiveType(typeId: 0)
class OrderModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  double contracts;
  @HiveField(2)
  double enterPoint;
  @HiveField(3)
  int stopLoss;
  @HiveField(4)
  int expectedTakeProfit;
  @HiveField(5)
  DateTime executionTime;
  @HiveField(6)
  OperationModel operation;
  @HiveField(7)
  PaperModel paper;
  @HiveField(8)
  OrderStatusEnum status;

  OrderModel({
    this.id,
    required this.operation,
    required this.paper,
    required this.contracts,
    required this.enterPoint,
    required this.stopLoss,
    required this.expectedTakeProfit,
    required this.executionTime,
    required this.status,
  });


}
