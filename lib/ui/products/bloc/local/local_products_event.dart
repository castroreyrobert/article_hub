
import '../../../../domain/entities/products/product_entity.dart';

abstract class LocalProductEvent {
  const LocalProductEvent();
}

abstract class FavoriteProductsEvent extends LocalProductEvent {
  const FavoriteProductsEvent();
}

abstract class RecentProductsEvent extends LocalProductEvent {
}

class GetFavoriteProductsEvent extends FavoriteProductsEvent {
  const GetFavoriteProductsEvent();
}

class GetRecentProductsEvent extends LocalProductEvent {
  const GetRecentProductsEvent();
}

class AddToFavoriteProductsEvent extends FavoriteProductsEvent {
  final ProductEntity product;
  const AddToFavoriteProductsEvent({required this.product});
}

class RemoveFromFavoriteProductsEvent extends FavoriteProductsEvent {
  final ProductEntity product;
  const RemoveFromFavoriteProductsEvent({required this.product});
}

class RemoveFromRecentProductsEvent extends LocalProductEvent {
  final ProductEntity product;
  const RemoveFromRecentProductsEvent({required this.product});
}

class AddToRecentProductsEvent extends LocalProductEvent {
  final ProductEntity product;
  const AddToRecentProductsEvent({required this.product});
}

class ClearRecentProductsEvent extends LocalProductEvent {
  const ClearRecentProductsEvent();
}