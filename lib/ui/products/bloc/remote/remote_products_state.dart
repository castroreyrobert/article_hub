import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteProductsState extends Equatable {
  final List<ProductEntity> ? products;
  final ErrorResponse ? errorMessage;

  const RemoteProductsState({this.products, this.errorMessage});

  @override
  List<Object?> get props => [products!, errorMessage!];
}

class RemoteProductsIdle extends RemoteProductsState {
  const RemoteProductsIdle();
}

class RemoteProductsSuccess extends RemoteProductsState {
  const RemoteProductsSuccess({super.products});
}

class RemoteProductsFailure extends RemoteProductsState {
  const RemoteProductsFailure({super.errorMessage});

}

class RemoteProductsLoading extends RemoteProductsState {
  const RemoteProductsLoading();
}