
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/data/data_sources/remote/articles/article_api_services.dart';
import 'package:article_hub/data/models/articles/article_model.dart';
import 'package:article_hub/domain/repositories/articles/article_repository.dart';
import 'package:article_hub/data/models/error_response.dart';

class ArticleRepositoryImp implements ArticleRepository {
  final ArticleApiServices articleApiServices;
  ArticleRepositoryImp(this.articleApiServices);
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
    final response = await articleApiServices.getArticles();
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