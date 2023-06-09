// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/models/paper_model.dart';

import '../../../../models/operation_model.dart';

enum OrderRegistrationStatusEnum {
  idle,
  getListSuccess,
}

class OrderRegistrationState extends BaseBlocState {
  final OrderRegistrationStatusEnum status;
  final List<OperationModel> operationList;
  final List<PaperModel> paperList;
  final OperationModel? selectedOperation;
  final PaperModel? selectedPaper;
  final DateTime? selectedDate;

  const OrderRegistrationState({
    required super.baseStatus,
    required super.errorMessage,
    required this.status,
    required this.operationList,
    required this.paperList,
    required this.selectedOperation,
    required this.selectedPaper,
    required this.selectedDate,
  });

  OrderRegistrationState.initial()
      : status = OrderRegistrationStatusEnum.idle,
        selectedOperation = null,
        selectedPaper = null,
        operationList = [],
        paperList = [],
        selectedDate = DateTime.now(),
        super.initial();

  @override
  List<Object?> get props => [
        status,
        operationList,
        paperList,
        baseStatus,
        selectedOperation,
        selectedPaper,
        selectedDate,
      ];

  @override
  OrderRegistrationState copyWith(
      {OrderRegistrationStatusEnum? status,
      String? errorMessage,
      BaseBlocStatus? baseStatus,
      List<OperationModel>? operationList,
      List<PaperModel>? paperList,
      OperationModel? selectedOperation,
      PaperModel? selectedPaper,
      DateTime? selectedDate}) {
    return OrderRegistrationState(
      status: status ?? this.status,
      baseStatus: baseStatus ?? this.baseStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      operationList: operationList ?? this.operationList,
      paperList: paperList ?? this.paperList,
      selectedOperation: selectedOperation ?? this.selectedOperation,
      selectedPaper: selectedPaper ?? this.selectedPaper,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
