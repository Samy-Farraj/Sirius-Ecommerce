part of 'dash_board_bloc.dart';

sealed class DashBoardState extends Equatable {
  const DashBoardState();

  @override
  List<Object> get props => [];
}

class DashBoardInitial extends DashBoardState {}

class LoadingGetStatisticsState extends DashBoardState {}

class DoneGetStatisticsState extends DashBoardState {
  Statistics statistics;
  DoneGetStatisticsState(this.statistics);
  @override
  List<Object> get props => [];
}

class ErrorGetStatisticsState extends DashBoardState {
  final String message;
  ErrorGetStatisticsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
