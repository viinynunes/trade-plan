import '../../../models/operation_model.dart';

abstract class OperationDatasource {
  Future<OperationModel> create(OperationModel operation);

  Future<OperationModel> update(OperationModel operation);

  Future<OperationModel> disable(OperationModel operation);

  Future<List<OperationModel>> getOperations();
}
