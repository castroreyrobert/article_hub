
import 'package:article_hub/core/utils/dio_builder.dart';
import 'package:article_hub/data/data_sources/remote/articles/article_api_services.dart';
import 'package:article_hub/data/data_sources/remote/authentication/authentication_api_services.dart';
import 'package:article_hub/data/data_sources/remote/products/product_api_services.dart';
import 'package:article_hub/data/repositories/articles/article_repository_imp.dart';
import 'package:article_hub/data/repositories/authentication/authentication_repository.dart';
import 'package:article_hub/data/repositories/products/product_repository_imp.dart';
import 'package:article_hub/domain/repositories/articles/article_repository.dart';
import 'package:article_hub/domain/repositories/authentication/authentication_repository.dart';
import 'package:article_hub/domain/repositories/products/product_repository.dart';
import 'package:article_hub/domain/usecases/articles/get_articles_usecase.dart';
import 'package:article_hub/domain/usecases/authentication/login_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_products_usecase.dart';
import 'package:article_hub/ui/authentication/bloc/remote_authentication_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final dependencyInjector = GetIt.instance;

Future<void> setUpDependencyInjector() async {
  dependencyInjector.registerSingleton(getDio());

  dependencyInjector.registerSingleton(ProductApiServices(dependencyInjector()));

  dependencyInjector.registerSingleton<ProductRepository>(ProductRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingleton(ArticleApiServices(dependencyInjector()));

  dependencyInjector.registerSingleton<ArticleRepository>(ArticleRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingleton(GetProductsUseCase(dependencyInjector()));

  dependencyInjector.registerFactory<RemoteProductsBloc>(() => RemoteProductsBloc(dependencyInjector<GetProductsUseCase>()));

  dependencyInjector.registerSingleton(GetArticlesUseCase(dependencyInjector()));

  dependencyInjector.registerSingleton(AuthenticationApiServices(dependencyInjector<Dio>()));

  dependencyInjector.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingleton<LoginUseCase>(LoginUseCase(dependencyInjector<AuthenticationRepository>()));

  dependencyInjector.registerFactory<RemoteAuthenticationBloc>(() => RemoteAuthenticationBloc(loginUseCase: dependencyInjector<LoginUseCase>()));

}