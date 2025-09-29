part of 'prodcut_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class LoadingMoreProductsState extends ProductState {
  final PaginatedProduct oldProduct;
  LoadingMoreProductsState(this.oldProduct);

  @override
  List<Object> get props => [oldProduct];
}

class LoadingProductsState extends ProductState {}

class DoneProductsState extends ProductState {
  PaginatedProduct product;

  DoneProductsState(this.product);
  @override
  List<Object> get props => [product];
}

class ErrorProductsState extends ProductState {
  final String message;
  ErrorProductsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingDeleteProductState extends ProductState {}

class DoneDeleteProductState extends ProductState {}

class ErrorDeleteProductState extends ProductState {
  final String message;
  ErrorDeleteProductState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingShowProductState extends ProductState {}

class DoneShowProductState extends ProductState {
  Product product;
  DoneShowProductState(this.product);
  @override
  List<Object> get props => [product];
}

class ErrorShowProductState extends ProductState {
  final String message;
  ErrorShowProductState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingCreateNewProductState extends ProductState {}

class DoneCreateNewProductState extends ProductState {}

class ErrorCreateNewProductState extends ProductState {
  final String message;
  ErrorCreateNewProductState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
