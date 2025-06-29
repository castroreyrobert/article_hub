
import 'dart:io';

import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/data/data_sources/remote/authentication/authentication_api_services.dart';
import 'package:article_hub/data/models/authentication/login_request.dart' show LoginRequest;
import 'package:article_hub/data/models/authentication/user_model.dart';
import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/domain/repositories/authentication/authentication_repository.dart';
import 'package:retrofit/retrofit.dart';


class AuthenticationRepositoryImp implements AuthenticationRepository {

  final AuthenticationApiServices apiServices;
  AuthenticationRepositoryImp(this.apiServices);
  @override
  Future<DataState<LoginUserModel>> login(String email, String password) async {
    try {
      final HttpResponse<LoginUserModel> httpResponse = await apiServices.login(
          LoginRequest(username: email, password: password));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Success(
            data: LoginUserModel.fromJson(httpResponse.response.data));
      } else {
        return Failure(
            ErrorResponse.fromJson(httpResponse.response.data)
        );
      }
    } catch (e) {
      return Failure(
          ErrorResponse(message: 'Something went wrong')
      );
    }
  }
}