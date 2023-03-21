// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:trade_plan/models/operation_model.dart';

enum OperationListStatus { initial, loading, error, success }

class OperationListState extends Equatable {
  final OperationListStatus status;
  final String? errorMessage;
  final List<OperationModel> operationList;

  const OperationListState({
    required this.status,
    this.errorMessage,
    required this.operationList,
  });

  const OperationListState.initial()
      : status = OperationListStatus.initial,
        errorMessage = null,
        operationList = const [];

  @override
  List<Object?> get props => [status, operationList, errorMessage];

  OperationListState copyWith({
    OperationListStatus? status,
    String? errorMessage,
    List<OperationModel>? operationList,
  }) {
    return OperationListState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      operationList: operationList ?? this.operationList,
    );
  }
}
