part of 'dash_board_bloc.dart';

abstract class DashBoardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllStatisticsEvent extends DashBoardEvent {
  String period;

  GetAllStatisticsEvent({
    required this.period,
  });
}
