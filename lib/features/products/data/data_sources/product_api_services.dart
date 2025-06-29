

import 'package:article_hub/core/utils/constants.dart';
import 'package:article_hub/features/products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'product_api_services.g.dart';

@RestApi(baseUrl: authBaseURL)
abstract class ProductApiServices {
  factory ProductApiServices(Dio dio, {String baseUrl}) = _ProductApiServices;

  @GET("products")
  Future<HttpResponse<ProductListResponse>> getProducts();
}