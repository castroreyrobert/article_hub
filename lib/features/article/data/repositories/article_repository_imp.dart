
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/article/data/data_sources/remote/article_api_services.dart';
import 'package:article_hub/features/article/data/model/article_model.dart';
import 'package:article_hub/features/article/domain/repository/article_repository.dart';
import 'package:article_hub/features/authentication/data/models/error_response.dart';

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