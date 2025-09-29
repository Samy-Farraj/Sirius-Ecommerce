part of 'filters_bloc.dart';

sealed class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends FiltersState {}

class LoadingGetFilterProductState extends FiltersState {}

class DoneGetFilterProductState extends FiltersState {
  FilterEntity filter;
  DoneGetFilterProductState(this.filter);
  @override
  List<Object> get props => [];
}

class ErrorGetFilterProductState extends FiltersState {
  final String message;
  ErrorGetFilterProductState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
