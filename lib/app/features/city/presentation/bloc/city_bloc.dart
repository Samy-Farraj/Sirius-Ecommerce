import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/entities/city.dart';
import '../../domain/usecases/get_all_cities_use_case.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetAllCitiesUseCase getAllCitiesUseCase;
  List<City> cities = [];
  String cityId = "";
  String cityName = "";
  City city = City();
  CityBloc({required this.getAllCitiesUseCase}) : super(CityInitial()) {
    on<GetAllCitiesEvent>(_onGetAllCitiesEvent);
    on<SelectCityEvent>(_onSelectCityEvent);
  }

  Future<void> _onSelectCityEvent(
    SelectCityEvent event,
    Emitter<CityState> emit,
  ) async {
    cityId = event.cityId;
    cityName = event.cityName;
    city = event.city;
    print("DSDS:DSD${cityId}");
    emit(SelectedCityState());
    emit(DoneGetCitiesState(cities));
  }

  Future<void> _onGetAllCitiesEvent(
    GetAllCitiesEvent event,
    Emitter<CityState> emit,
  ) async {
    emit(LoadingGetCitiesState());

    final result = await getAllCitiesUseCase.call(NoParameters());

    result.fold(
      (failure) {
        emit(ErrorGetCitiesState(message: failure.message));
      },
      (cities) {
        this.cities = cities;
        emit(DoneGetCitiesState(cities));
      },
    );
  }
}
