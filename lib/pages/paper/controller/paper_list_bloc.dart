import 'package:bloc/bloc.dart';
import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/data/paper/repositories/paper_repository.dart';
import 'package:trade_plan/models/paper_model.dart';
import 'package:trade_plan/pages/paper/controller/states/paper_list_state.dart';

class PaperListBloc extends Cubit<PaperListState> {
  final PaperRepository _paperRepository;

  PaperListBloc(this._paperRepository) : super(const PaperListState.initial());

  void getPaperList() async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _paperRepository.getPaperList();

    await Future.delayed(const Duration(milliseconds: 200));

    result.fold(
        (paperList) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.success, paperList: paperList)),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void registerPaper({required PaperModel paper}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _paperRepository.create(paper: paper);

    result.fold(
        (success) => getPaperList(),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void updatePaper({required PaperModel paper}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _paperRepository.update(paper: paper);

    result.fold(
        (success) => getPaperList(),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }

  void disablePaper({required PaperModel paper}) async {
    emit(state.copyWith(baseStatus: BaseBlocStatus.loading));

    final result = await _paperRepository.disable(paper: paper);

    result.fold(
        (success) => getPaperList(),
        (failure) => emit(state.copyWith(
            baseStatus: BaseBlocStatus.error, errorMessage: failure.message)));
  }
}
