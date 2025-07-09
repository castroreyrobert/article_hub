import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteProductsState extends Equatable {
  final List<ProductEntity> ? products;
  final List<ProductCategoryEntity> ? categories;
  final ErrorResponse ? errorMessage;
  final ProductEntity ? productDetails;

  const RemoteProductsState({this.products, this.categories, this.errorMessage, this.productDetails});

  @override
  List<Object?> get props => [products, categories, errorMessage!];
}

class RemoteProductsIdle extends RemoteProductsState {
  const RemoteProductsIdle();
}

class RemoteProductsSuccess extends RemoteProductsState {
  const RemoteProductsSuccess({super.products});
}

class RemoteProductCategorySuccess extends RemoteProductsState {
  const RemoteProductCategorySuccess({super.categories});
}

class GetProductDetailsSuccess extends RemoteProductsState {
  const GetProductDetailsSuccess({super.productDetails});
}

class RemoteProductsFailure extends RemoteProductsState {
  const RemoteProductsFailure({super.errorMessage});

}

class RemoteProductsLoading extends RemoteProductsState {
  const RemoteProductsLoading();
}