import 'package:trade_plan/data/operation/datasources/operation_datasource.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveOperationDatasource implements OperationDatasource {
  final HiveInterface hive;
  late final Box box;

  HiveOperationDatasource(this.hive) {
    box = hive.box('operationBox');
  }

  @override
  Future<OperationModel> create(OperationModel operation) async {
    box.add(operation);

    return operation;
  }

  @override
  Future<OperationModel> disable(OperationModel operation) async {
    box.delete(operation.key);

    return operation;
  }

  @override
  Future<List<OperationModel>> getOperations() async {
    List<OperationModel> operationList = [];

    for (var o in box.values) {
      operationList.add(o);
    }

    return operationList;
  }

  @override
  Future<OperationModel> update(OperationModel operation) async {
    box.put(operation.id, operation);

    return operation;
  }
}
