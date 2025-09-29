part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends NotificationsState {}

class LoadingCategoriesState extends NotificationsState {}

class DoneCategoriesState extends NotificationsState {
  List<Category> categories;
  DoneCategoriesState(this.categories);
  @override
  List<Object> get props => [];
}

class ErrorCategoriesState extends NotificationsState {
  final String message;
  ErrorCategoriesState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
