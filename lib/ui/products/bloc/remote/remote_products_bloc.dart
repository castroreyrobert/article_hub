import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/usecases/products/get_product_category_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_products_usecase.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteProductsBloc extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductCategoryUseCase getProductCategoryUseCase;

  RemoteProductsBloc(this.getProductsUseCase, this.getProductCategoryUseCase): super(RemoteProductsIdle()) {
    on<GetProductsCategoriesEvent>(onGetProductCategories);
    on<GetProductsEvent>(onGetProducts);
  }


  void onGetProductCategories(GetProductsCategoriesEvent event, Emitter<RemoteProductsState> emit) async {
    emit(RemoteProductsLoading());
    final dataStateProducts = await getProductCategoryUseCase.invoke();
    if (dataStateProducts is Success) {
      final categories = dataStateProducts.data;
      emit(RemoteProductCategorySuccess(categories: categories));
    } else {
      emit(RemoteProductsFailure(errorMessage: (dataStateProducts as Failure).error));
    }
  }

  void onGetProducts(GetProductsEvent event, Emitter<RemoteProductsState> emit) async {
    emit(RemoteProductsLoading());
    final dataState = await getProductsUseCase.invoke(params: event.category);
    if (dataState is Success) {
      final products = dataState.data;
      emit(RemoteProductsSuccess(products: products));
    } else {
      emit(RemoteProductsFailure(errorMessage: (dataState as Failure).error));
    }
  }
}