
import 'package:article_hub/domain/usecases/products/add_to_favorites_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_recent_products_usecase.dart';
import 'package:article_hub/domain/usecases/products/remove_from_recent_usecase.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/products/add_to_recent_usecase.dart';
import '../../../../domain/usecases/products/delete_all_recent_usecase.dart';
import '../../../../domain/usecases/products/get_favorite_products_usecase.dart';
import '../../../../domain/usecases/products/remove_from_favorites_usecase.dart';
import 'local_products_event.dart';
import 'local_products_state.dart';

class LocalProductsBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final GetFavoriteProductsUseCase getFavoriteProductsUseCase;
  final GetRecentProductsUseCase getRecentProductsUseCase;
  final AddToFavoritesUseCase addToFavoriteProductsUseCase;
  final RemoveFromFavoriteUseCase removeFromFavoriteProductsUseCase;
  final RemoveFromRecentUseCase removeFromRecentProductsUseCase;
  final AddToRecentUseCase addToRecentProductsUseCase;
  final DeleteAllRecentUseCase deleteAllRecentProductsUseCase;

  LocalProductsBloc(
      this.getFavoriteProductsUseCase,
      this.getRecentProductsUseCase,
      this.addToFavoriteProductsUseCase,
      this.removeFromFavoriteProductsUseCase,
      this.removeFromRecentProductsUseCase,
      this.addToRecentProductsUseCase,
      this.deleteAllRecentProductsUseCase
  ): super(const LocalProductIdle()) {
    on<AddToRecentProductsEvent>(onAddRecentProducts);
    on<GetRecentProductsEvent>(onGetRecentProducts);
    on<ClearRecentProductsEvent>(onClearRecentProducts);
    on<AddToFavoriteProductsEvent>(onAddFavoriteProducts);
    on<GetFavoriteProductsEvent>(onGetFavoriteProducts);
  }

  void onAddRecentProducts(AddToRecentProductsEvent event, Emitter<LocalProductState> emit) async {
    await addToRecentProductsUseCase.invoke(params: event.product);
    emit(LocalProductGenericSuccess());
  }

  void onGetRecentProducts(GetRecentProductsEvent event, Emitter<LocalProductState> emit) async {
    emit(LocalProductLoading());
    final result = await getRecentProductsUseCase.invoke();
    emit(LocalRecentProductSuccess(recentProducts: result));
  }

  void onClearRecentProducts(ClearRecentProductsEvent event, Emitter<LocalProductState> emit) async {
    emit(LocalProductLoading());
    await deleteAllRecentProductsUseCase.invoke();
    emit(LocalRecentProductSuccess(recentProducts: []));
  }

  void onAddFavoriteProducts(AddToFavoriteProductsEvent event, Emitter<LocalProductState> emit) async {
    await addToFavoriteProductsUseCase.invoke(params: event.product);
    emit(LocalProductGenericSuccess());
  }

  void onGetFavoriteProducts(GetFavoriteProductsEvent event, Emitter<LocalProductState> emit) async {
    emit(LocalProductLoading());
    final result = await getFavoriteProductsUseCase.invoke();
    emit(LocalFavoriteProductSuccess(favoriteProducts: result));

  }
}