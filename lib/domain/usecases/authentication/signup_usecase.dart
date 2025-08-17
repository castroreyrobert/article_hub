import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/core/resources/use_case.dart';
import '../../../data/models/authentication/login_request.dart';
import '../../entities/authentication/user_entity.dart';
import '../../repositories/authentication/authentication_repository.dart';

class SignupUseCase implements UseCase<DataState<UserEntity>, LoginRequest>{
  final AuthenticationRepository repository;
  SignupUseCase(this.repository);

  @override
  Future<DataState<UserEntity>> invoke({LoginRequest ? params}) async {
    return repository.signUp(params!.username, params.password);
  }
}
