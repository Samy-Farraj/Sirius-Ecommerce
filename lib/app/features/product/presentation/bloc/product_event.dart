part of 'prodcut_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductEvent {
  GetProductParams params;
  GetAllProductsEvent({required this.params});
}

class CreateNewProductEvent extends ProductEvent {
  NewProductParameter parameter;
  CreateNewProductEvent({required this.parameter});
}

class EditProductEvent extends ProductEvent {
  NewProductParameter parameter;
  EditProductEvent({required this.parameter});
}

class DeleteProductByIdEvent extends ProductEvent {
  String productId;
  DeleteProductByIdEvent({required this.productId});
}

class ShowProductByIdEvent extends ProductEvent {
  String productId;
  ShowProductByIdEvent({required this.productId});
}

