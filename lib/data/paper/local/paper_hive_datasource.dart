import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/data/paper/datasources/paper_datasource.dart';
import 'package:trade_plan/models/paper_model.dart';

class PaperHiveDatasource implements PaperDatasource {
  final HiveInterface _hive;

  late final Box box;

  PaperHiveDatasource(this._hive) {
    box = _hive.box('paperBox');
  }

  @override
  Future<PaperModel> create({required PaperModel paper}) async {
    box.add(paper);

    return paper;
  }

  @override
  Future<PaperModel> disable({required PaperModel paper}) async {
    box.delete(paper.key);

    return paper;
  }

  @override
  Future<List<PaperModel>> getPaperList() async {
    List<PaperModel> paperList = [];

    for (var p in box.values) {
      paperList.add(p);
    }

    return paperList;
  }

  @override
  Future<PaperModel> update({required PaperModel paper}) async {
    box.put(paper.id, paper);

    return paper;
  }
}
