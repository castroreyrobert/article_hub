import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});

}

class Success<T> extends DataState<T> {
  Success({super.data});
}

class Failure<T> extends DataState<T> {
  const Failure(DioException error) : super(error: error);
}