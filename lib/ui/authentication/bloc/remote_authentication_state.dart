
import 'package:article_hub/data/models/error_response.dart';
import 'package:article_hub/domain/entities/authentication/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

sealed class RemoteAuthenticationState extends Equatable {
  final LoginUserEntity ? user;
  final ErrorResponse ? errorMessage;

  const RemoteAuthenticationState({this.user, this.errorMessage});

  @override
  List<Object?> get props => [user!, errorMessage!];
}

class RemoteAuthIdle extends RemoteAuthenticationState {
  const RemoteAuthIdle();
}

class RemoteAuthSuccess extends RemoteAuthenticationState {
  const RemoteAuthSuccess({super.user});
}

class RemoteAuthFailure extends RemoteAuthenticationState {
  const RemoteAuthFailure({super.errorMessage});

}

class RemoteAuthLoading extends RemoteAuthenticationState {
  const RemoteAuthLoading();
}