import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import '../../../data/models/authentication/login_request.dart';
import '../../entities/authentication/user_entity.dart';
import '../../repositories/authentication/authentication_repository.dart';

class LoginUseCase implements UseCase<DataState<LoginUserEntity>, LoginRequest>{
  final AuthenticationRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<DataState<LoginUserEntity>> invoke({LoginRequest ? params}) async {
    return repository.login(params!.username, params.password);
  }
}
