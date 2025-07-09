

import 'package:article_hub/core/utils/constants.dart';
import 'package:article_hub/data/models/products/product_category_model.dart';
import 'package:article_hub/data/models/products/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'product_api_services.g.dart';

@RestApi(baseUrl: authBaseURL)
abstract class ProductApiServices {
  factory ProductApiServices(Dio dio, {String baseUrl}) = _ProductApiServices;

  @GET('products')
  Future<HttpResponse<ProductListResponse>> getProducts();

  @GET('products/categories')
  Future<HttpResponse<List<ProductCategoryModel>>> getProductCategories();

  @GET('products/category/{category}')
  Future<HttpResponse<ProductListResponse>> getProductsByCategory(@Path('category') String category);

  @GET('products')
  Future<HttpResponse<ProductListResponse>> getProductsByQuery();

}