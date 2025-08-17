
import 'package:article_hub/core/utils/constants.dart';
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
import 'package:article_hub/domain/usecases/products/add_to_favorites_usecase.dart';
import 'package:article_hub/domain/usecases/products/add_to_recent_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_product_category_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_product_details_usecase.dart';
import 'package:article_hub/domain/usecases/products/get_products_by_category.dart';
import 'package:article_hub/domain/usecases/products/get_products_usecase.dart';
import 'package:article_hub/ui/authentication/bloc/remote_authentication_bloc.dart';
import 'package:article_hub/ui/products/bloc/remote/remote_products_bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_sources/local/app_database.dart';
import '../../domain/usecases/authentication/signup_usecase.dart';
import '../../domain/usecases/products/delete_all_recent_usecase.dart';
import '../../domain/usecases/products/get_favorite_products_usecase.dart';
import '../../domain/usecases/products/get_recent_products_usecase.dart';
import '../../domain/usecases/products/remove_from_favorites_usecase.dart';
import '../../domain/usecases/products/remove_from_recent_usecase.dart';
import '../../ui/products/bloc/local/local_products_bloc.dart';
import '../configs/flavor_config.dart';

final dependencyInjector = GetIt.instance;

Future<void> setUpDependencyInjector() async {

  await Firebase.initializeApp();

  final String dynamicBaseUrl = FlavorConfig.instance.baseUrl;

  dependencyInjector.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  dependencyInjector.registerSingletonAsync<AppDatabase>(() async {
    // ... your Floor database builder ...
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database.db')
    // .addCallback(AppDatabaseCallback) // If you still have this
        .build();
    return database;
  });

  dependencyInjector.registerSingleton(getDio(dynamicBaseUrl));

  dependencyInjector.registerSingleton(ProductApiServices(dependencyInjector()));

  dependencyInjector.registerSingletonWithDependencies<ProductRepository>(
        () => ProductRepositoryImp(
        dependencyInjector<ProductApiServices>(), // Injected dependency
        dependencyInjector<AppDatabase>()         // Injected dependency
    ),
    dependsOn: [AppDatabase], // Explicitly state that AppDatabase must be ready
  );

  dependencyInjector.registerSingleton(ArticleApiServices(dependencyInjector()));

  dependencyInjector.registerSingleton<ArticleRepository>(ArticleRepositoryImp(dependencyInjector()));

  dependencyInjector.registerSingletonWithDependencies<GetProductsUseCase>(
        () => GetProductsUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<GetProductCategoryUseCase>(
        () => GetProductCategoryUseCase(dependencyInjector()),
    dependsOn: [ProductRepository],
  );

  dependencyInjector.registerSingletonWithDependencies<GetProductsByCategoryUseCase>(
        () => GetProductsByCategoryUseCase(dependencyInjector()),
    dependsOn: [ProductRepository],
  );

  dependencyInjector.registerSingletonWithDependencies<GetProductDetailsUseCase>(
        () => GetProductDetailsUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<AddToFavoritesUseCase>(
      () => AddToFavoritesUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<RemoveFromFavoriteUseCase>(
      () => RemoveFromFavoriteUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<GetFavoriteProductsUseCase>(
      () => GetFavoriteProductsUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<GetRecentProductsUseCase>(
          () => GetRecentProductsUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<AddToRecentUseCase>(()
      => AddToRecentUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<RemoveFromRecentUseCase>(
          () => RemoveFromRecentUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );

  dependencyInjector.registerSingletonWithDependencies<DeleteAllRecentUseCase>(
          () => DeleteAllRecentUseCase(dependencyInjector()),
    dependsOn: [ProductRepository]
  );


  dependencyInjector.registerFactory<LocalProductsBloc>(() => LocalProductsBloc(
    dependencyInjector<GetFavoriteProductsUseCase>(),
    dependencyInjector<GetRecentProductsUseCase>(),
    dependencyInjector<AddToFavoritesUseCase>(),
    dependencyInjector<RemoveFromFavoriteUseCase>(),
    dependencyInjector<RemoveFromRecentUseCase>(),
    dependencyInjector<AddToRecentUseCase>(),
    dependencyInjector<DeleteAllRecentUseCase>())
  );


  dependencyInjector.registerFactory<RemoteProductsBloc>(() => RemoteProductsBloc(
      dependencyInjector<GetProductsUseCase>(),
      dependencyInjector<GetProductCategoryUseCase>(),
      dependencyInjector<GetProductDetailsUseCase>(),
      dependencyInjector<GetProductsByCategoryUseCase>())
  );


  dependencyInjector.registerSingleton(GetArticlesUseCase(dependencyInjector()));

  dependencyInjector.registerSingleton(AuthenticationApiServices(dependencyInjector<Dio>()));

  dependencyInjector.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImp(dependencyInjector(), dependencyInjector()));

  dependencyInjector.registerSingleton<LoginUseCase>(LoginUseCase(dependencyInjector<AuthenticationRepository>()));

  dependencyInjector.registerSingleton<SignupUseCase>(SignupUseCase(dependencyInjector<AuthenticationRepository>()));

  dependencyInjector.registerFactory<RemoteAuthenticationBloc>(() => RemoteAuthenticationBloc(loginUseCase: dependencyInjector<LoginUseCase>(), signUpUseCase: dependencyInjector<SignupUseCase>()));



}