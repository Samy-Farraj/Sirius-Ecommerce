part of 'branches_bloc.dart';

sealed class BranchesState extends Equatable {
  const BranchesState();

  @override
  List<Object> get props => [];
}

class BranchesInitial extends BranchesState {}

class AddBranchLocation extends BranchesState {}

class LoadingStoreNewBranchState extends BranchesState {}

class DoneStoreNewBranchState extends BranchesState {}

class ErrorStoreNewBranchState extends BranchesState {
  final String message;
  ErrorStoreNewBranchState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingDeleteBranchState extends BranchesState {}

class DoneDeleteBranchState extends BranchesState {}

class ErrorDeleteBranchState extends BranchesState {
  final String message;
  ErrorDeleteBranchState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingUpdateBranchState extends BranchesState {}

class DoneUpdateBranchState extends BranchesState {}

class ErrorUpdateBranchState extends BranchesState {
  final String message;
  ErrorUpdateBranchState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
