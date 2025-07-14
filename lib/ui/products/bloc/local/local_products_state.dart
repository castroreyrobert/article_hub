
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/products/product_entity.dart';

abstract class LocalProductState extends Equatable {
  final List<ProductEntity> ? recentProducts;
  final List<ProductEntity> ? favoriteProducts;

  final String ? errorMessage;

  const LocalProductState({this.recentProducts, this.favoriteProducts, this.errorMessage});

  @override
  List<Object?> get props => [recentProducts, favoriteProducts, errorMessage];

}

class LocalProductIdle extends LocalProductState {
  const LocalProductIdle();
}

class LocalFavoriteProductSuccess extends LocalProductState {
  const LocalFavoriteProductSuccess({super.favoriteProducts});
}

class LocalRecentProductSuccess extends LocalProductState {
  const LocalRecentProductSuccess({super.recentProducts});
}

class LocalProductFailure extends LocalProductState {
  const LocalProductFailure({super.errorMessage});
}

class LocalProductGenericSuccess extends LocalProductState  {
  const LocalProductGenericSuccess();
}

class LocalProductLoading extends LocalProductState {
  const LocalProductLoading();
}