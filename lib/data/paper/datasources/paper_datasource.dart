import 'package:trade_plan/models/paper_model.dart';

abstract class PaperDatasource {
  Future<PaperModel> create({required PaperModel paper});

  Future<PaperModel> update({required PaperModel paper});

  Future<PaperModel> disable({required PaperModel paper});

  Future<List<PaperModel>> getPaperList();
}
