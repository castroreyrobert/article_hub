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

  return dio;
}