import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import 'package:article_hub/features/authentication/data/models/user_model.dart';

import '../entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class LoginUseCase implements UseCase<DataState<LoginUserEntity>, (String, String)>{
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<DataState<LoginUserEntity>> invoke({(String, String) ? params}) {
    return repository.login(params != null ? params.$1 : "", params != null ? params.$2 : "");
  }
}
