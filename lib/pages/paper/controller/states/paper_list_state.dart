import 'package:trade_plan/core/ui/bloc/base_bloc_state.dart';
import 'package:trade_plan/models/paper_model.dart';

class PaperListState extends BaseBlocState {
  final List<PaperModel> paperList;

  const PaperListState({
    required super.baseStatus,
    required super.errorMessage,
    required this.paperList,
  });

  const PaperListState.initial()
      : paperList = const [],
        super.initial();

  @override
  List<Object?> get props => [paperList];

  @override
  PaperListState copyWith({
    BaseBlocStatus? baseStatus,
    String? errorMessage,
    List<PaperModel>? paperList,
  }) {
    return PaperListState(
      baseStatus: baseStatus ?? this.baseStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      paperList: paperList ?? this.paperList,
    );
  }
}
