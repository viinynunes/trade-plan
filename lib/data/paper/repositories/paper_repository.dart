import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/core/exceptions/base_repository_exception.dart';
import 'package:trade_plan/models/paper_model.dart';

abstract class PaperRepository {
  AsyncResult<PaperModel, BaseRepositoryException> create(
      {required PaperModel paper});

  AsyncResult<PaperModel, BaseRepositoryException> update(
      {required PaperModel paper});

  AsyncResult<PaperModel, BaseRepositoryException> disable({required PaperModel paper});

  AsyncResult<List<PaperModel>, BaseRepositoryException> getPaperList();
}
