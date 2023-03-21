import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trade_plan/models/closed_order_model.dart';
import 'package:trade_plan/models/enums/order_result_enum.dart';
import 'package:trade_plan/models/enums/order_status_enum.dart';
import 'package:trade_plan/models/operation_model.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:trade_plan/models/paper_model.dart';

class HiveConfiguration {
  static Future<void> config() async {
    final dir = await getApplicationDocumentsDirectory();

    await Hive.initFlutter(dir.path);

    _registerBox();

    await _openBox();
  }

  static void _registerBox() {
    Hive.registerAdapter(OrderModelAdapter());
    Hive.registerAdapter(ClosedOrderModelAdapter());
    Hive.registerAdapter(OperationModelAdapter());
    Hive.registerAdapter(PaperModelAdapter());
    Hive.registerAdapter(OrderResultStatusAdapter());
    Hive.registerAdapter(OrderStatusEnumAdapter());
  }

  static Future<void> _openBox() async {
    await Hive.openBox('orderBox');
    await Hive.openBox('closedOrderBox');
    await Hive.openBox('paperBox');
    await Hive.openBox('operationBox');
  }
}
