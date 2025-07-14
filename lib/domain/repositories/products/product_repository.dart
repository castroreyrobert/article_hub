import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/entities/products/product_category_entity.dart';
import 'package:article_hub/domain/entities/products/product_entity.dart';

abstract class ProductRepository {

  Future<DataState<List<ProductEntity>>> getProducts(String ? query);

  Future<DataState<List<ProductCategoryEntity>>> getProductCategories();

  Future<DataState<List<ProductEntity>>> getProductsByCategory(String category);

  Future<DataState<ProductEntity>> getProductDetails(int id);

  Future<List<ProductEntity>> getFavoriteProducts();

  Future<void> addFavoriteProduct(ProductEntity product);

  Future<void> removeFromFavoriteProducts(ProductEntity product);

  Future<List<ProductEntity>> getRecentProducts();

  Future<void> addRecentProduct(ProductEntity product);

  Future<void> removeFromRecentProducts(ProductEntity product);

  Future<void> clearRecentProducts();

}