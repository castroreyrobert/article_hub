
import 'package:floor/floor.dart';

import '../../../models/products/product_model.dart';

@dao
abstract class ProductDao {

  @Query('SELECT * FROM products')
  Future<List<ProductModel>> getFavorites();

  @insert
  Future<void> addToFavorites(ProductModel product);

  @delete
  Future<void> removeFromFavorites(ProductModel product);

  @Query('SELECT * FROM recent_products')
  Future<List<RecentProductModel>> getRecentProducts();

  @insert
  Future<void> addToRecent(RecentProductModel product);

  @delete
  Future<void> removeFromRecent(RecentProductModel product);

  @Query('DELETE FROM recent_products')
  Future<void> clearRecentProducts();

}