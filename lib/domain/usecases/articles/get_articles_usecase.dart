
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/domain/entities/articles/article_entity.dart';

import '../../repositories/articles/article_repository.dart';

class GetArticlesUseCase extends UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;
  GetArticlesUseCase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> invoke({void params}) {
    return articleRepository.getArticles();
  }

}