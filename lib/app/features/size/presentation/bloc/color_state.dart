part of 'color_bloc.dart';

sealed class SizeState extends Equatable {
  const SizeState();

  @override
  List<Object> get props => [];
}

class SizeInitial extends SizeState {}

class LoadingSizesState extends SizeState {}

class DoneSizesState extends SizeState {
  List<SizeEntity> sizes;
  DoneSizesState(this.sizes);
  @override
  List<Object> get props => [];
}

class ErrorSizesState extends SizeState {
  final String message;
  ErrorSizesState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
