
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/data/data_sources/remote/products/product_api_services.dart';
import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/data/models/products/product_category_model.dart';
import 'package:article_hub/data/models/products/product_model.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';
import 'package:retrofit/dio.dart';

import '../../../domain/entities/products/product_entity.dart';
import '../../data_sources/local/app_database.dart';

class ProductRepositoryImp extends ProductRepository {
  final ProductApiServices apiServices;
  final AppDatabase database;
  ProductRepositoryImp(this.apiServices, this.database);
  @override
  Future<DataState<List<ProductEntity>>> getProducts(String ? query) async {
    
    HttpResponse<ProductListResponse> response;
    if(query != null) {
      response = await apiServices.getProductsByQuery(query);
    } else {
      response = await apiServices.getProducts();
    }
    final favorites = await database.productDao.getFavorites();
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.products?.map((model) => model.toEntityInstanceMethod(isFavorite: favorites.any((e) => e.id == model.id))).toList());
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }

  }

  @override
  Future<DataState<List<ProductCategoryModel>>> getProductCategories() async {
    final response = await apiServices.getProductCategories();
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data);
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> getProductsByCategory(String category) async {
    final response = await apiServices.getProductsByCategory(category);
    final favorites = await database.productDao.getFavorites();
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.products?.map((model) => model.toEntityInstanceMethod(isFavorite: favorites.any((e) => e.id == model.id))).toList());
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }
  }

  @override
  Future<DataState<ProductEntity>> getProductDetails(int id) async {
    final response = await apiServices.getProductDetails(id);
    final favorites = await database.productDao.getFavorites();
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.toEntityInstanceMethod(isFavorite: favorites.any((e) => e.id == response.data.id)));
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }
  }

  @override
  Future<void> removeFromFavoriteProducts(ProductEntity product) {
    return database.productDao.removeFromFavorites(ProductModel.fromEntity(product));
  }

  @override
  Future<void> addFavoriteProduct(ProductEntity product) {
    return database.productDao.addToFavorites(ProductModel.fromEntity(product));
  }

  @override
  Future<List<ProductEntity>> getFavoriteProducts() {
    return database.productDao.getFavorites().then((value) => value.map((e) => e.toEntityInstanceMethod(isFavorite: true)).toList());
  }

  @override
  Future<void> addRecentProduct(ProductEntity product) {
    return database.productDao.addToRecent(RecentProductModel.fromEntity(product));
  }

  @override
  Future<void> removeFromRecentProducts(ProductEntity product) {
   return database.productDao.removeFromRecent(RecentProductModel.fromEntity(product));
  }

  @override
  Future<List<ProductEntity>> getRecentProducts() {
   return database.productDao.getRecentProducts().then((value) => value.map((e) => e.toEntityInstanceMethod()).toList());
  }

  @override
  Future<void> clearRecentProducts() {
    return database.productDao.clearRecentProducts();
  }
}