import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/services/order_result_service.dart';

import 'states/close_order_state.dart';

class CloseOrderBloc extends Cubit<CloseOrderState> {
  final OrderResultService _orderResult;

  CloseOrderBloc(this._orderResult) : super(const CloseOrderState.initial());

  double calculateTaxByContract({
    required double contractNumber,
    required double taxByContract,
  }) {
    final tax = _orderResult.calculateTaxByContract(
        contractNumber: contractNumber, taxByContract: taxByContract);

    emit(state.copyWith(tax: tax));

    return tax;
  }

  void calculateMoneyResult({
    required double points,
    required double pointsPerTick,
    required double moneyByTick,
    required double contractNumber,
    required double? tax,
  }) {
    final moneyResult = _orderResult.calculateMoneyResult(
        points: points,
        pointsPerTick: pointsPerTick,
        moneyByTick: moneyByTick,
        contractNumber: contractNumber,
        tax: tax);

    emit(state.copyWith(moneyResult: moneyResult));
  }
}
