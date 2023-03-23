import 'package:bloc/bloc.dart';
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/data/operation/repositories/operation_repository.dart';
import 'package:trade_plan/data/paper/repositories/paper_repository.dart';
import 'package:trade_plan/models/operation_model.dart';

import 'states/order_registration_state.dart';

class OrderRegistrationBloc extends Cubit<OrderRegistrationState> {
  final OperationRepository _operationRepository;
  final PaperRepository _paperRepository;

  OrderRegistrationBloc(this._operationRepository, this._paperRepository)
      : super(OrderRegistrationState.initial());

  void getPaperList() async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _paperRepository.getPaperList();

    result.fold((paperList) {
      emit(state.copyWith(
          status: OrderRegistrationStatusEnum.getListSuccess,
          paperList: paperList));
    }, (failure) => null);
  }

  void getOperationList() async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _operationRepository.getOperations();

    result.fold((operationList) {
      emit(state.copyWith(
          status: OrderRegistrationStatusEnum.getListSuccess,
          operationList: operationList));
    },
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void selectOperation({required OperationModel? selectedOperation}) {
    emit(state.copyWith(selectedOperation: selectedOperation));
  }
}
