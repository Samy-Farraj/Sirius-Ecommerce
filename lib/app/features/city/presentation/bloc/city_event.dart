part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllCitiesEvent extends CityEvent {}

class SelectCityEvent extends CityEvent {
  String cityId;
  City city;
  String cityName;

  SelectCityEvent(
      {required this.cityId, required this.city, required this.cityName});
}
