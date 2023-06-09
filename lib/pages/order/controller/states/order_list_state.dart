import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/models/closed_order_model.dart';
import 'package:trade_plan/models/order_model.dart';

enum OrderStatusEnum {
  idle,
  changeDate,
}

class OrderListState extends BaseBlocState {
  final List<OrderModel> openedOrderList;
  final List<ClosedOrderModel> closedOrderList;
  final OrderStatusEnum status;
  final DateTime? selectedDate;

  const OrderListState({
    required super.errorMessage,
    required super.baseStatus,
    required this.status,
    required this.openedOrderList,
    required this.closedOrderList,
    required this.selectedDate,
  });

  OrderListState.initial()
      : openedOrderList = const [],
        closedOrderList = const [],
        status = OrderStatusEnum.idle,
        selectedDate = DateTime.now(),
        super.initial();

  @override
  List<Object?> get props =>
      [baseStatus, status, openedOrderList, closedOrderList, selectedDate];

  @override
  OrderListState copyWith({
    BaseBlocStatus? baseStatus,
    OrderStatusEnum? status,
    String? errorMessage,
    List<OrderModel>? openedOrderList,
    List<ClosedOrderModel>? closedOrderList,
    DateTime? selectedDate,
  }) {
    return OrderListState(
      baseStatus: baseStatus ?? this.baseStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      openedOrderList: openedOrderList ?? this.openedOrderList,
      closedOrderList: closedOrderList ?? this.closedOrderList,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
