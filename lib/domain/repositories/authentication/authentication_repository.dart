
import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/domain/entities/authentication/user_entity.dart';

abstract class AuthenticationRepository {
  Future<DataState<UserEntity>> login(String username, String password);

}