import 'package:article_hub/data/models/error_response.dart';
import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final ErrorResponse? error;

  const DataState({this.data, this.error});

}

class Success<T> extends DataState<T> {
  Success({super.data});
}

class Failure<T> extends DataState<T> {
  const Failure(ErrorResponse error) : super(error: error);
}