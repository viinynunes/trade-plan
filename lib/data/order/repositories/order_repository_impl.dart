import 'dart:developer';

import 'package:result_dart/result_dart.dart';
import 'package:trade_plan/core/exceptions/base_repository_exception.dart';
import 'package:trade_plan/data/order/datasources/order_datasource.dart';

import 'package:trade_plan/data/order/repositories/order_repository.dart';
import 'package:trade_plan/models/closed_order_model.dart';
import 'package:trade_plan/models/order_model.dart';

import '../datasources/closed_order_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDatasource _orderDatasource;
  final ClosedOrderDatasource _closedOrderDatasource;

  OrderRepositoryImpl(this._orderDatasource, this._closedOrderDatasource);

  @override
  AsyncResult<OrderModel, BaseRepositoryException> disableOrder(
      OrderModel order) async {
    try {
      final result = await _orderDatasource.disableOrder(order);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<OrderModel, BaseRepositoryException> disableClosedOrder(
      ClosedOrderModel order) async {
    try {
      final result = await _closedOrderDatasource.disableOrder(order);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<List<OrderModel>, BaseRepositoryException>
      getOpenedOrderListByDate({required DateTime date}) async {
    try {
      final result =
          await _orderDatasource.getOpenedOrderListByDate(date: date);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);

      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<List<ClosedOrderModel>, BaseRepositoryException>
      getClosedOrderListByDate({required DateTime date}) async {
    try {
      final result =
          await _closedOrderDatasource.getClosedOrderListByDate(date: date);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<OrderModel, BaseRepositoryException> registerOrder(
      OrderModel order) async {
    try {
      final result = await _orderDatasource.registerOrder(order);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<ClosedOrderModel, BaseRepositoryException> closeOrder(
      ClosedOrderModel order) async {
    try {
      final closeResult = await _closedOrderDatasource.closeOrder(order);

      await _orderDatasource.disableOrder(order);

      return Success(closeResult);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }

  @override
  AsyncResult<OrderModel, BaseRepositoryException> updateOrder(
      OrderModel order) async {
    try {
      final result = await _orderDatasource.updateOrder(order);

      return Success(result);
    } catch (e) {
      log('Error on order repository', error: e);
      return Failure(
          BaseRepositoryException(message: 'Error on order repository'));
    }
  }
}
