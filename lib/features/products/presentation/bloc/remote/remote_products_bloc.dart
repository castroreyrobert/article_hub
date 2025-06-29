import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/products/domain/usecases/get_products_usecase.dart';
import 'package:article_hub/features/products/presentation/bloc/remote/remote_products_event.dart';
import 'package:article_hub/features/products/presentation/bloc/remote/remote_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteProductsBloc extends Bloc<RemoteProductsEvent, RemoteProductsState> {
  final GetProductsUseCase getProductsUseCase;

  RemoteProductsBloc(this.getProductsUseCase): super(RemoteProductsIdle()) {
    on<GetProductsEvent>(onGetProducts);
  }


  void onGetProducts(GetProductsEvent event, Emitter<RemoteProductsState> emit) async {
    emit(RemoteProductsLoading());
    final dataState = await getProductsUseCase.invoke();
    if (dataState is Success) {
      final products = dataState.data;
      emit(RemoteProductsSuccess(products: products));
    } else if (dataState is Failure) {
      emit(RemoteProductsFailure(errorMessage: dataState.error));
  }
    }

}