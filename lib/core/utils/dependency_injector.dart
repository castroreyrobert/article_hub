
import 'package:article_hub/core/utils/dio_builder.dart';
import 'package:article_hub/features/article/data/data_sources/remote/article_api_services.dart';
import 'package:article_hub/features/article/data/repositories/article_repository_imp.dart';
import 'package:article_hub/features/article/domain/repository/article_repository.dart';
import 'package:article_hub/features/article/domain/usecases/get_articles_usecase.dart';
import 'package:article_hub/features/article/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:article_hub/features/authentication/data/data_sources/remote/authentication_api_services.dart';
import 'package:article_hub/features/authentication/data/repositories/authentication_repository.dart';
import 'package:article_hub/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:article_hub/features/authentication/domain/usecases/login_usecase.dart';
import 'package:article_hub/features/authentication/presentation/bloc/remote_authentication_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final dependencyInjector = GetIt.instance;

Future<void> setUpDependencyInjector() async {
  dependencyInjector.registerSingleton(getDio());

  dependencyInjector.registerSingleton(ArticleApiServices(dependencyInjector()));

  dependencyInjector.registerSingleton<ArticleRepository>(ArticleRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingleton(GetArticlesUseCase(dependencyInjector()));

  dependencyInjector.registerSingleton(AuthenticationApiServices(dependencyInjector<Dio>()));

  dependencyInjector.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingleton<LoginUseCase>(LoginUseCase(dependencyInjector<AuthenticationRepository>()));

  dependencyInjector.registerFactory<RemoteAuthenticationBloc>(() => RemoteAuthenticationBloc(loginUseCase: dependencyInjector<LoginUseCase>()));

  dependencyInjector.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(dependencyInjector<GetArticlesUseCase>()));

}