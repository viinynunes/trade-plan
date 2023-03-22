// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CloseOrderState extends Equatable {
  final double tax;
  final double moneyResult;
  final double riskReturn;

  const CloseOrderState({
    required this.tax,
    required this.moneyResult,
    required this.riskReturn,
  });

  const CloseOrderState.initial()
      : tax = 0,
        moneyResult = 0,
        riskReturn = 0;

  @override
  List<Object?> get props => [tax, moneyResult, riskReturn];

  CloseOrderState copyWith({
    double? tax,
    double? moneyResult,
    double? riskReturn,
  }) {
    return CloseOrderState(
      tax: tax ?? this.tax,
      moneyResult: moneyResult ?? this.moneyResult,
      riskReturn: riskReturn ?? this.riskReturn,
    );
  }
}
