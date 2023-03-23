import 'package:bloc/bloc.dart';
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/data/order/repositories/order_repository.dart';
import 'package:trade_plan/models/order_model.dart';
import 'package:trade_plan/pages/order/controller/states/order_list_state.dart';

import '../../../models/closed_order_model.dart';

class OrderListBloc extends Cubit<OrderListState> {
  final OrderRepository _repository;

  OrderListBloc(this._repository) : super(OrderListState.initial());

  void selectDate({required DateTime? selectedDate}) {
    getClosedOrderList(date: selectedDate ?? DateTime.now());
    getOpenedOrderList(date: selectedDate ?? DateTime.now());

    emit(state.copyWith(selectedDate: selectedDate));
  }

  void getOpenedOrderList({required DateTime date}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));
    final result = await _repository.getOpenedOrderListByDate(date: date);

    await Future.delayed(const Duration(milliseconds: 200));

    result.fold(
        (orderList) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.success, openedOrderList: orderList)),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void getClosedOrderList({required DateTime date}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));
    final result = await _repository.getClosedOrderListByDate(date: date);

    await Future.delayed(const Duration(milliseconds: 200));

    result.fold(
        (orderList) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.success, closedOrderList: orderList)),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void closeOrder(
      {required ClosedOrderModel order, required DateTime date}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));
    final result = await _repository.closeOrder(order);

    result.fold((success) {
      getClosedOrderList(date: date);
      getOpenedOrderList(date: date);
    },
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void registerOrder({required OrderModel order}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));
    final result = await _repository.registerOrder(order);

    result.fold(
        (success) {},
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void updateOrder({required OrderModel order}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));
    final result = await _repository.updateOrder(order);

    result.fold(
        (success) => emit(state.copyWith(baseStatus: BaseBlocStatus.success)),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void disableOrder({required OrderModel order, required DateTime date}) async {
    final result = await _repository.disableOrder(order);

    result.fold((success) {
      getClosedOrderList(date: date);
      getOpenedOrderList(date: date);
    },
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void disableClosedOrder(
      {required ClosedOrderModel order, required DateTime date}) async {
    final result = await _repository.disableClosedOrder(order);

    result.fold((success) {
      getClosedOrderList(date: date);
      getOpenedOrderList(date: date);
    },
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }
}
