import 'dart:developer';

import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/core/exceptions/base_repository_exception.dart';
import 'package:trade_plan/data/paper/datasources/paper_datasource.dart';
import 'package:trade_plan/data/paper/repositories/paper_repository.dart';
import 'package:trade_plan/models/paper_model.dart';

class PaperRepositoryImpl implements PaperRepository {
  final PaperDatasource _datasource;

  PaperRepositoryImpl(this._datasource);

  @override
  AsyncResult<PaperModel, BaseRepositoryException> create(
      {required PaperModel paper}) async {
    try {
      final result = await _datasource.create(paper: paper);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Paper Repository', error: e);
      return Failure(BaseRepositoryException(message: e.toString()));
    }
  }

  @override
  AsyncResult<PaperModel, BaseRepositoryException> disable(
      {required PaperModel paper}) async {
    try {
      final result = await _datasource.disable(paper: paper);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Paper Repository', error: e);
      return Failure(BaseRepositoryException(message: e.toString()));
    }
  }

  @override
  AsyncResult<List<PaperModel>, BaseRepositoryException> getPaperList() async {
    try {
      final result = await _datasource.getPaperList();

      return Success(result);
    } catch (e) {
      return Failure(
          BaseRepositoryException(message: 'Error on Paper Repository'));
    }
  }

  @override
  AsyncResult<PaperModel, BaseRepositoryException> update(
      {required PaperModel paper}) async {
    try {
      final result = await _datasource.update(paper: paper);

      return Success(result);
    } on Exception catch (e) {
      log('Error on Paper Repository', error: e);
      return Failure(BaseRepositoryException(message: e.toString()));
    }
  }
}
