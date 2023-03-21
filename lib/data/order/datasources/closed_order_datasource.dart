import '../../../models/closed_order_model.dart';

abstract class ClosedOrderDatasource {
  Future<ClosedOrderModel> closeOrder(ClosedOrderModel order);

    Future<ClosedOrderModel> disableOrder(ClosedOrderModel order);

  Future<List<ClosedOrderModel>> getClosedOrderListByDate(
      {required DateTime date});
}
