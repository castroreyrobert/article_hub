import 'package:article_hub/features/article/domain/entities/article_entity.dart';
import 'package:article_hub/features/authentication/data/models/error_response.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity> ? articles;
  final ErrorResponse ? errorMessage;

  const RemoteArticleState({this.articles, this.errorMessage});

  @override
  List<Object?> get props => [articles!, errorMessage!];
}

class RemoteArticleIdle extends RemoteArticleState {
  const RemoteArticleIdle();
}

class RemoteArticleSuccess extends RemoteArticleState {
  const RemoteArticleSuccess({super.articles});
}

class RemoteArticleFailure extends RemoteArticleState {
  const RemoteArticleFailure({super.errorMessage});

}

class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}