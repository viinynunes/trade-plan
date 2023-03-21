import 'package:hive_flutter/hive_flutter.dart';

part 'order_status_enum.g.dart';

@HiveType(typeId: 4)
enum OrderStatusEnum {
  @HiveField(0)
  open('Aberta'),
  @HiveField(1)
  closed('Fechada');

  final String text;

  const OrderStatusEnum(this.text);
}
