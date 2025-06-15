
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/features/article/domain/entities/article_entity.dart';

import '../repository/article_repository.dart';

class GetArticlesUseCase extends UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;
  GetArticlesUseCase(this.articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> invoke({void params}) {
    return articleRepository.getArticles();
  }

}