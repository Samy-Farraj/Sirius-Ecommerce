part of 'city_bloc.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class LoadingGetCitiesState extends CityState {}

class SelectedCityState extends CityState {}

class DoneGetCitiesState extends CityState {
  List<City> cites;
  DoneGetCitiesState(this.cites);
  @override
  List<Object> get props => [];
}

class ErrorGetCitiesState extends CityState {
  final String message;
  ErrorGetCitiesState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
