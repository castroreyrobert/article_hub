
import 'dart:io';

import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/data/data_sources/remote/authentication/authentication_api_services.dart';
import 'package:article_hub/data/models/authentication/login_request.dart' show LoginRequest;
import 'package:article_hub/data/models/authentication/user_model.dart';
import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/domain/repositories/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrofit/retrofit.dart';


class AuthenticationRepositoryImp implements AuthenticationRepository {

  final AuthenticationApiServices apiServices;
  final FirebaseAuth firebaseAuth;

  AuthenticationRepositoryImp(this.apiServices, this.firebaseAuth);
  @override
  Future<DataState<UserModel>> login(String email, String password) async {
    try {
      final HttpResponse<UserModel> httpResponse = await apiServices.login(
          LoginRequest(username: email, password: password));
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return Success(
            data: UserModel.fromJson(httpResponse.response.data));
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

  @override
  Future<DataState<UserModel>> loginFirebase(String email, String password) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        return Success(
          data: UserModel.fromFirebaseUser(response.user!),
        );
      } else {
        return Failure(
            ErrorResponse(message: 'Something went wrong')
        );
      }
    } catch(e) {
      return Failure(
          ErrorResponse(message: e.toString())
      );
    }
  }

  @override
  Future<DataState<UserModel>> signUp(String email, String password) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        return Success(
          data: UserModel.fromFirebaseUser(response.user!),
        );
      } else {
        return Failure(
            ErrorResponse(message: 'Something went wrong')
        );
      }
    } catch (e) {
      return Failure(
          ErrorResponse(message: e.toString())
      );
    }
  }

  @override
  Future<DataState<void>> logout() async {
    try {
      final response = await firebaseAuth.signOut();
        return Success();
    } catch (e) {
      return Failure(
          ErrorResponse(message: e.toString())
      );
    }
  }
}