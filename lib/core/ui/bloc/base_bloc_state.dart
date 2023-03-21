// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum BaseBlocStatus { initial, loading, error, success }

class BaseBlocState extends Equatable {
  final BaseBlocStatus baseStatus;
  final String? errorMessage;

  const BaseBlocState({
    required this.baseStatus,
    this.errorMessage,
  });

  const BaseBlocState.initial()
      : baseStatus = BaseBlocStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [baseStatus, errorMessage];

  BaseBlocState copyWith({
    BaseBlocStatus? baseStatus,
    String? errorMessage,
  }) {
    return BaseBlocState(
      baseStatus: baseStatus ?? this.baseStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
