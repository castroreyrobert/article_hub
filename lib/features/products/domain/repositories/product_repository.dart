import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/products/domain/entities/product_entity.dart';

abstract class ProductRepository {

  Future<DataState<List<ProductEntity>>> getProducts();
}