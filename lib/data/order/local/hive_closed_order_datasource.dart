import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/core/extensions/date_format_extension.dart';
import 'package:trade_plan/data/order/datasources/closed_order_datasource.dart';
import 'package:trade_plan/models/closed_order_model.dart';

import '../../../models/enums/order_status_enum.dart';

class HiveClosedOrderDatasource implements ClosedOrderDatasource {
  final HiveInterface _hive;
  late final Box box;

  HiveClosedOrderDatasource(this._hive) {
    box = _hive.box('closedOrderBox');
  }

  @override
  Future<ClosedOrderModel> closeOrder(ClosedOrderModel order) async {
    box.add(order);

    return order;
  }

  @override
  Future<ClosedOrderModel> disableOrder(ClosedOrderModel order) async {
    box.delete(order.key);

    return order;
  }

  @override
  Future<List<ClosedOrderModel>> getClosedOrderListByDate(
      {required DateTime date}) async {
    List<ClosedOrderModel> closedList = [];

    for (var v in box.values) {
      closedList.add(v);
    }

    closedList.removeWhere((order) =>
        order.status != OrderStatusEnum.closed ||
        order.closeTime.onlyDateFormat != date.onlyDateFormat);

    closedList.sort((a, b) => a.executionTime.compareTo(b.executionTime));

    return closedList;
  }
}
