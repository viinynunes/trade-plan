import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'order_result_enum.g.dart';

@HiveType(typeId: 3)
enum OrderResultStatus {
  @HiveField(0)
  win('WIN', Colors.green),
  @HiveField(1)
  loss('LOSS', Colors.red),
  @HiveField(2)
  tie('EMPATE', Colors.blue);

  final String text;
  final Color defaultColor;

  const OrderResultStatus(this.text, this.defaultColor);
}
