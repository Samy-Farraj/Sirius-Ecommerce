part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class LoadingCategoriesState extends CategoriesState {}

class DoneCategoriesState extends CategoriesState {
  List<Category> categories;
  DoneCategoriesState(this.categories);
  @override
  List<Object> get props => [];
}

class ErrorCategoriesState extends CategoriesState {
  final String message;
  ErrorCategoriesState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
