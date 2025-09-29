part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFilterValueEvent extends FiltersEvent {}
