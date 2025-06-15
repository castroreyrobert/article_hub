
import 'dart:io';

import 'package:article_hub/core/utils/constants.dart';
import 'package:article_hub/features/article/data/model/article_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'article_api_services.g.dart';

@RestApi(baseUrl: postsBaseURL)
abstract class ArticleApiServices {
  factory ArticleApiServices(Dio dio, {String baseUrl}) = _ArticleApiServices;

  @GET("albums/1/photos")
  Future<HttpResponse<List<ArticleModel>>> getArticles();

}