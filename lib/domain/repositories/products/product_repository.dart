import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';

abstract class ProductRepository {

  Future<DataState<List<ProductEntity>>> getProducts(String ? query);

  Future<DataState<List<ProductCategoryEntity>>> getProductCategories();

  Future<DataState<List<ProductEntity>>> getProductsByCategory(String category);

  Future<DataState<List<ProductEntity>>> getProductsByQuery(String ? query);

}