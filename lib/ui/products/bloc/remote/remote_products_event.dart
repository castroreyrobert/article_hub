
import 'package:article_hub/domain/entities/products/product_entity.dart';

abstract class RemoteProductsEvent {
  const RemoteProductsEvent();
}

class GetProductsEvent extends RemoteProductsEvent {
  final String ? category;
  final String ? query;
  const GetProductsEvent({this.category, this.query});
}

class GetProductsCategoriesEvent extends RemoteProductsEvent {
  const GetProductsCategoriesEvent();
}

class GetProductDetailsEvent extends RemoteProductsEvent {
  final int id;
  const GetProductDetailsEvent({required this.id});
}

class UpdateProductDetailsEvent extends RemoteProductsEvent {
  const UpdateProductDetailsEvent();
}