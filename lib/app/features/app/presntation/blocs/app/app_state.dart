part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

final class AppInitial extends AppState {}

final class LogInAgainInApp extends AppState {}

class LoadingGetAppState extends AppState {}

class DoneGetAppState extends AppState {
  final String currentVersionName;
  final App? app;
  const DoneGetAppState({
    required this.currentVersionName,
    this.app,
  });
  @override
  List<Object?> get props => [currentVersionName, app];
}

class ErrorGetAppState extends AppState {
  final String message;
  const ErrorGetAppState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
