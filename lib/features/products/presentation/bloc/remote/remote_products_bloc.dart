import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/article/domain/usecases/get_articles_usecase.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_event.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_articles_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticleBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticlesUseCase getArticlesUseCase;

  RemoteArticleBloc(this.getArticlesUseCase) : super(RemoteArticleIdle()){
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(GetArticlesEvent event, Emitter<RemoteArticleState> emitter) async {
    emitter(RemoteArticleLoading());
    final dataState = await getArticlesUseCase.invoke();
    if (dataState is Success) {
      final articles = dataState.data;
      emitter(RemoteArticleSuccess(articles: articles));
    } else if (dataState is Failure) {
      emitter(RemoteArticleFailure(errorMessage: dataState.error));
    }
  }
}