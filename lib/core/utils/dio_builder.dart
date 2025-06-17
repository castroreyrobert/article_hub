import 'package:article_hub/core/utils/constants.dart';
import 'package:dio/dio.dart';

Dio getDio() {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  final dio = Dio(options);
  dio.interceptors.add(LogInterceptor(
    requestHeader: true,
    requestBody: true, // VERY IMPORTANT for 400 errors
    responseHeader: true,
    responseBody: true, // VERY IMPORTANT to see server error details
    error: true,
  ));

  return dio;
}