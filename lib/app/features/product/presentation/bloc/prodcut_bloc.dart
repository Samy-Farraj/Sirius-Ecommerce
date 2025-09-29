import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sirius/app/features/color/domain/entities/my_color.dart';
import 'package:sirius/app/features/product/data/models/NewProductParameter.dart';
import 'package:sirius/app/features/product/domain/entities/paginated_product.dart';
import 'package:sirius/app/features/product/domain/entities/product.dart';
import 'package:sirius/app/features/product/domain/usecases/delete_product_use_case.dart';
import 'package:sirius/app/features/product/domain/usecases/edit_product_use_case.dart';
import 'package:sirius/app/features/product/domain/usecases/get_products_use_case.dart';
import 'package:sirius/app/features/product/domain/usecases/show_product_details_by_id_use_case.dart';
import 'package:sirius/app/features/size/domain/entities/size_entity.dart';
import 'package:sirius/src/core/architecture/base_usecase.dart';

import '../../domain/usecases/create_new_product_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  DeleteProductUseCase deleteProductUseCase;
  ShowProductDetailsByIdUseCase showProductDetailsByIdUseCase;

  CreateNewProductUseCase createNewProductUseCase;
  EditProductUseCase editProductUseCase;
  bool isFetching = false;
  ProductBloc({
    required this.showProductDetailsByIdUseCase,
    required this.getProductsUseCase,
    required this.createNewProductUseCase,
    required this.editProductUseCase,
    required this.deleteProductUseCase,
  }) : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProductsEvent);
    on<ShowProductByIdEvent>(_onShowProductByIdEvent);

    on<DeleteProductByIdEvent>(_onDeleteProductByIdEvent);
    on<CreateNewProductEvent>(_onCreateNewProductEvent);
    on<EditProductEvent>(_onEditProductEvent);
  }
  Future<void> _onEditProductEvent(
    EditProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingCreateNewProductState());
    final result = await editProductUseCase.call(event.parameter);
    result.fold(
      (failure) {
        emit(ErrorCreateNewProductState(message: failure.message));
      },
      (_) {
        emit(DoneCreateNewProductState());
      },
    );
  }

  Future<void> _onCreateNewProductEvent(
    CreateNewProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingCreateNewProductState());
    final result = await createNewProductUseCase.call(event.parameter);
    result.fold(
      (failure) {
        emit(ErrorCreateNewProductState(message: failure.message));
      },
      (_) {
        emit(DoneCreateNewProductState());
      },
    );
  }

  Future<void> _onDeleteProductByIdEvent(
    DeleteProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingDeleteProductState());
    final result = await deleteProductUseCase.call(event.productId);
    result.fold(
      (failure) {
        emit(ErrorDeleteProductState(message: failure.message));
      },
      (_) {
        emit(DoneDeleteProductState());
      },
    );
  }

  Future<void> _onShowProductByIdEvent(
    ShowProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingShowProductState());
    final result = await showProductDetailsByIdUseCase.call(event.productId);
    result.fold(
      (failure) {
        emit(ErrorShowProductState(message: failure.message));
      },
      (product) {
        emit(DoneShowProductState(product));
      },
    );
  }

  Future<void> _onGetAllProductsEvent(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    List<Product> oldProducts = [];
    log("THE OLD ARRA Y IN ! ${oldProducts}");
    log("event.params.page ! ${event.params.page}");
    log("event.params.page ! ${currentState is DoneProductsState}");

    if (event.params.page != 1 && currentState is DoneProductsState) {
      oldProducts = currentState.product.data ?? [];
      emit(LoadingMoreProductsState(currentState.product));
    } else {
      if (event.params.page == 1) {
        emit(LoadingProductsState());
      }
    }

    final result = await getProductsUseCase.call(event.params);
    print("THE STATEAA");
    result.fold(
      (failure) {
        print("THE STATEAA FFFFFFF");

        emit(ErrorProductsState(message: failure.message));
      },
      (newPage) {
        print("THE STATEAA TTTTT!!!!${oldProducts.length}");
        print("THE STATEAA TTTTT!!!!${newPage.data?.length}");
        final updatedProducts = [...oldProducts, ...?newPage.data];
        final updatedPaginatedProduct = newPage.copyWith(
          data: updatedProducts,
        );
        print("THE STATEAA TTTTT!!!!222222");
        emit(DoneProductsState(updatedPaginatedProduct));
      },
    );
  }
}
