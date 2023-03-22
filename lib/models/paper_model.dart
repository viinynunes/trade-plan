// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'paper_model.g.dart';

@HiveType(typeId: 2)
class PaperModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double? taxByContract;
  @HiveField(3)
  double pointsPerTicks;
  @HiveField(4)
  double moneyByTick;

  PaperModel({
    this.id,
    required this.name,
    required this.pointsPerTicks,
    required this.moneyByTick,
    this.taxByContract,
  });
}
