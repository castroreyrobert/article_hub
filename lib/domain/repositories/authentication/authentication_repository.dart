
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/entities/authentication/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<DataState<UserEntity>> login(String username, String password);

  Future<DataState<UserEntity>> signUp(String email, String password);

  Future<DataState<void>> logout();

  Future<DataState<UserEntity>> loginFirebase(String email, String password);

}