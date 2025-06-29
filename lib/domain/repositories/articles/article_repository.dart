

import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/entities/articles/article_entity.dart';


abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();
}