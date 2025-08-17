import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/usecases/products/get_product_category_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_product_details_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_products_by_category.dart';
import 'package:article_hub/domain/usecases/products/get_products_usecase.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteProductsBloc extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductCategoryUseCase getProductCategoryUseCase;
  final GetProductDetailsUseCase getProductDetailsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  RemoteProductsBloc(
      this.getProductsUseCase,
      this.getProductCategoryUseCase,
      this.getProductDetailsUseCase,
      this.getProductsByCategoryUseCase
  ): super(RemoteProductsIdle()) {
    on<GetProductsCategoriesEvent>(onGetProductCategories);
    on<GetProductsEvent>(onGetProducts);
    on<GetProductDetailsEvent>(onGetProductDetails);
    on<UpdateProductDetailsEvent>(onUpdateProductDetails);
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
    final dataState = event.category != null ?
    await getProductsByCategoryUseCase.invoke(params: event.category) :
    await getProductsUseCase.invoke(params: event.query);

    if (dataState is Success) {
      final products = dataState.data;
      emit(RemoteProductsSuccess(products: products));
    } else {
      emit(RemoteProductsFailure(errorMessage: (dataState as Failure).error));
    }
  }

  void onGetProductDetails(GetProductDetailsEvent event, Emitter<RemoteProductsState> emit) async {
    emit(RemoteProductsLoading());
    final dataState = await getProductDetailsUseCase.invoke(params: event.id);
    if (dataState is Success) {
      final details = dataState.data;
      emit(GetProductDetailsSuccess(productDetails: details));
    } else {
      emit(RemoteProductsFailure(errorMessage: (dataState as Failure).error));
    }
  }

  void onUpdateProductDetails(UpdateProductDetailsEvent event, Emitter<RemoteProductsState> emit) async {
    final dataState = event.category != null ?
    await getProductsByCategoryUseCase.invoke(params: event.category) :
    await getProductsUseCase.invoke(params: event.query);

    if (dataState is Success) {
      final products = dataState.data;
      emit(RemoteProductsSuccess(products: products));
    } else {
      emit(RemoteProductsFailure(errorMessage: (dataState as Failure).error));
    }
  }
}