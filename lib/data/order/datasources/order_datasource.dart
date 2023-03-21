import 'package:trade_plan/models/order_model.dart';

abstract class OrderDatasource {
  Future<OrderModel> registerOrder(OrderModel order);

  Future<OrderModel> updateOrder(OrderModel order);

  Future<OrderModel> disableOrder(OrderModel order);

  Future<List<OrderModel>> getOpenedOrderListByDate({required DateTime date});
}
