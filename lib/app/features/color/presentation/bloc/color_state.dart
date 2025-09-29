part of 'color_bloc.dart';

sealed class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {}

class LoadingColorsState extends ColorState {}

class DoneColorsState extends ColorState {
  List<MyColor> colors;
  DoneColorsState(this.colors);
  @override
  List<Object> get props => [];
}

class ErrorColorsState extends ColorState {
  final String message;
  ErrorColorsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
