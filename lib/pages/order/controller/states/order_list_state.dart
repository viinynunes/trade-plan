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

  const OrderListState({
    required super.errorMessage,
    required super.baseStatus,
    required this.status,
    required this.openedOrderList,
    required this.closedOrderList,
  });

  const OrderListState.initial()
      : openedOrderList = const [],
        closedOrderList = const [],
        status = OrderStatusEnum.idle,
        super.initial();

  @override
  List<Object?> get props =>
      [baseStatus, status, openedOrderList, closedOrderList];

  @override
  OrderListState copyWith({
    BaseBlocStatus? baseStatus,
    OrderStatusEnum? status,
    String? errorMessage,
    List<OrderModel>? openedOrderList,
    List<ClosedOrderModel>? closedOrderList,
  }) {
    return OrderListState(
      baseStatus: baseStatus ?? this.baseStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      openedOrderList: openedOrderList ?? this.openedOrderList,
      closedOrderList: closedOrderList ?? this.closedOrderList,
    );
  }
}
