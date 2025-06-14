
import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/authentication/data/data_sources/remote/authentication_api_services.dart';
import 'package:article_hub/features/authentication/data/models/user_model.dart';
import 'package:article_hub/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {

  final AuthenticationApiServices apiServices;
  AuthenticationRepositoryImp(this.apiServices);
  @override
  Future<DataState<LoginUserModel>> login(String email, String password) async {
    try {
      final HttpResponse<LoginUserModel> httpResponse = await apiServices.login(
          loginRequest: LoginRequest(email: email, password: password));

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Success(
            data: LoginUserModel.fromJson(httpResponse.response.data));
      } else {
        return Failure(
            DioException(
                requestOptions: httpResponse.response.requestOptions,
                response: httpResponse.response
            )
        );
      }
    } catch (e) {
      return Failure(
          DioException(
              requestOptions: RequestOptions(path: ''),
              error: e
          )
      );
    }
  }
}