
import 'package:article_hub/domain/entities/authentication/user_entity.dart';

sealed class AccountDetailsRemoteState {
  final String? errorMessage;
  final UserEntity? user;
  const AccountDetailsRemoteState( {this.errorMessage, this.user});
}

class GetAccountDetailsLoadingState extends AccountDetailsRemoteState {
  const GetAccountDetailsLoadingState();
}

class GetAccountDetailsSuccessState extends AccountDetailsRemoteState {
  const GetAccountDetailsSuccessState({super.user});
}

class GetAccountDetailsFailure extends AccountDetailsRemoteState {
  const GetAccountDetailsFailure({super.errorMessage});
}