import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/models/closed_order_model.dart';

import '../../../core/exceptions/base_repository_exception.dart';
import '../../../models/order_model.dart';

abstract class OrderRepository {
  AsyncResult<OrderModel, BaseRepositoryException> registerOrder(
      OrderModel order);

  AsyncResult<ClosedOrderModel, BaseRepositoryException> closeOrder(
      ClosedOrderModel order);

  AsyncResult<OrderModel, BaseRepositoryException> updateOrder(
      OrderModel order);

  AsyncResult<OrderModel, BaseRepositoryException> disableOrder(
      OrderModel order);

  AsyncResult<OrderModel, BaseRepositoryException> disableClosedOrder(
      ClosedOrderModel order);

  AsyncResult<List<OrderModel>, BaseRepositoryException>
      getOpenedOrderListByDate({required DateTime date});

  AsyncResult<List<ClosedOrderModel>, BaseRepositoryException>
      getClosedOrderListByDate({required DateTime date});
}
