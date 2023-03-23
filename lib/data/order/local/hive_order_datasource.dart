import 'package:hive_flutter/hive_flutter.dart';
import 'package:trade_plan/data/order/datasources/order_datasource.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:trade_plan/models/enums/order_status_enum.dart';

const orderBox = 'orderBox';

class HiveOrderDatasource implements OrderDatasource {
  final HiveInterface _hive;

  late Box box;

  HiveOrderDatasource(this._hive) {
    box = _hive.box(orderBox);
  }

  @override
  Future<OrderModel> disableOrder(OrderModel order) async {
    box.delete(order.key);

    return order;
  }

  @override
  Future<List<OrderModel>> getOpenedOrderListByDate(
      {required DateTime date}) async {
    List<OrderModel> orderList = [];

    for (var v in box.values) {
      orderList.add(v);
    }

    orderList.removeWhere((order) => order.status != OrderStatusEnum.open);

    orderList.sort((a, b) => a.executionTime.compareTo(b.executionTime));

    return orderList;
  }

  @override
  Future<OrderModel> registerOrder(OrderModel order) async {
    box.add(order);

    return order;
  }

  @override
  Future<OrderModel> updateOrder(OrderModel order) async {
    box.put(order.key, order);

    return order;
  }
}
