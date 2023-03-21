import 'dart:developer';

import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/core/exceptions/base_repository_exception.dart';
import 'package:trade_plan/data/operation/datasources/operation_datasource.dart';
import 'package:trade_plan/models/operation_model.dart';

import 'operation_repository.dart';

class OperationRepositoryImpl implements OperationRepository {
  final OperationDatasource _datasource;

  OperationRepositoryImpl(this._datasource);

  @override
  AsyncResult<OperationModel, BaseRepositoryException> create(
      OperationModel operation) async {
    try {
      final result = await _datasource.create(operation);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Operation Repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on Operation Repository'));
    }
  }

  @override
  AsyncResult<OperationModel, BaseRepositoryException> disable(
      OperationModel operation) async {
    try {
      final result = await _datasource.disable(operation);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Operation Repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on Operation Repository'));
    }
  }

  @override
  AsyncResult<List<OperationModel>, BaseRepositoryException>
      getOperations() async {
    try {
      final result = await _datasource.getOperations();

      return Success(result);
    } catch (e) {
      throw Failure(
          BaseRepositoryException(message: 'Error on Operation Repository'));
    }
  }

  @override
  AsyncResult<OperationModel, BaseRepositoryException> update(
      OperationModel operation) async {
    try {
      final result = await _datasource.update(operation);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Operation Repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on Operation Repository'));
    }
  }
}
