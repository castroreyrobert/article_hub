
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

}