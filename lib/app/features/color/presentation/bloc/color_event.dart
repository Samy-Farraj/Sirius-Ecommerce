part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllColorsEvent extends ColorEvent {}
