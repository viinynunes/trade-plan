import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/models/operation_model.dart';

import '../../../core/exceptions/base_repository_exception.dart';

abstract class OperationRepository {
  AsyncResult<OperationModel, BaseRepositoryException> create(
      OperationModel operation);

  AsyncResult<OperationModel, BaseRepositoryException> update(
      OperationModel operation);

  AsyncResult<OperationModel, BaseRepositoryException> disable(OperationModel operation);

  AsyncResult<List<OperationModel>, BaseRepositoryException> getOperations();


}
