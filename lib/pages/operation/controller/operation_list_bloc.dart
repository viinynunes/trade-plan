import 'package:bloc/bloc.dart';
import 'package:trade_plan/data/operation/repositories/operation_repository.dart';
import 'package:trade_plan/pages/operation/controller/state/operation_list_state.dart';

import '../../../models/operation_model.dart';

class OperationListBloc extends Cubit<OperationListState> {
  final OperationRepository _operationRepository;

  OperationListBloc(this._operationRepository)
      : super(const OperationListState.initial());

  void getOperationList() async {
    emit(state.copyWith(status: OperationListStatus.loading));

    await Future.delayed(const Duration(milliseconds: 200));

    final result = await _operationRepository.getOperations();

    result.fold(
      (operationList) => emit(
        state.copyWith(
            status: OperationListStatus.success, operationList: operationList),
      ),
      (failure) => emit(
        state.copyWith(
            status: OperationListStatus.error, errorMessage: failure.message),
      ),
    );
  }

  void registerOperation({required OperationModel operation}) async {
    emit(state.copyWith(status: OperationListStatus.loading));

    final result = await _operationRepository.create(operation);

    result.fold(
      (operation) => getOperationList(),
      (failure) => emit(
        state.copyWith(
            status: OperationListStatus.error, errorMessage: failure.message),
      ),
    );
  }

  void updateOperation({required OperationModel operation}) async {
    emit(state.copyWith(status: OperationListStatus.loading));

    final result = await _operationRepository.update(operation);

    result.fold(
      (operation) => getOperationList(),
      (failure) => emit(
        state.copyWith(
            status: OperationListStatus.error, errorMessage: failure.message),
      ),
    );
  }

  void disableOperation({required OperationModel operation}) async {
    emit(state.copyWith(status: OperationListStatus.loading));

    final result = await _operationRepository.disable(operation);

    result.fold(
      (operation) => getOperationList(),
      (failure) => emit(
        state.copyWith(
            status: OperationListStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
