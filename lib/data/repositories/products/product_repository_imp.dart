
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
  //final AppDatabase database;
  ProductRepositoryImp(this.apiServices);
  @override
  Future<DataState<List<ProductModel>>> getProducts(String ? query) async {
    
    HttpResponse<ProductListResponse> response;
    if(query != null) {
      response = await apiServices.getProductsByCategory(query);
    } else {
      response = await apiServices.getProducts();
    }
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.products);
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
  Future<DataState<List<ProductModel>>> getProductsByCategory(String category) async {
    final response = await apiServices.getProductsByCategory(category);
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.products);
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }
  }

  @override
  Future<DataState<List<ProductModel>>> getProductsByQuery(String? query) async {
    final response = await apiServices.getProductsByQuery();
    try {
      if (response.response.statusCode == 200) {
        return Success(data: response.data.products);
      } else {
        return Failure(ErrorResponse.fromJson(response.response.data));
      }
    } catch(e) {
      return Failure(ErrorResponse(message: "Something went wrong!"));
    }
  }

  @override
  Future<DataState<ProductModel>> getProductDetails(int id) async {
    final response = await apiServices.getProductDetails(id);
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
}