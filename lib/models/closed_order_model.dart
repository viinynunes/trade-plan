import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/models/enums/order_result_enum.dart';
import 'package:trade_plan/models/enums/order_status_enum.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:trade_plan/models/paper_model.dart';

part 'closed_order_model.g.dart';

@HiveType(typeId: 5)
class ClosedOrderModel extends OrderModel {
  @HiveField(9)
  final DateTime closeTime;
  @HiveField(10)
  final OrderResultStatus result;
  @HiveField(11)
  final double pointsResult;
  @HiveField(12)
  final double moneyResult;
  @HiveField(13)
  final double? tax;

  ClosedOrderModel({
    required this.closeTime,
    required this.result,
    required this.pointsResult,
    required this.moneyResult,
    this.tax,
    required super.operation,
    required super.paper,
    required super.contracts,
    required super.enterPoint,
    required super.stopLoss,
    required super.expectedTakeProfit,
    required super.executionTime,
    required super.status,
  });
}
