

import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/article/domain/entities/article_entity.dart';


abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();
}