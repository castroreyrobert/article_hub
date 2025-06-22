import 'package:article_hub/core/resources/data_state.dart';
import 'package:article_hub/features/authentication/data/models/login_request.dart';
import 'package:article_hub/features/authentication/domain/usecases/login_usecase.dart';
import 'package:article_hub/features/authentication/presentation/bloc/remote_authentication_event.dart';
import 'package:article_hub/features/authentication/presentation/bloc/remote_authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteAuthenticationBloc extends Bloc<RemoteAuthenticationEvent, RemoteAuthenticationState> {
  final LoginUseCase loginUseCase;

  RemoteAuthenticationBloc({required this.loginUseCase}) : super(RemoteAuthIdle()){
    on<LoginEvent>(onLogin);
  }

  void onLogin(LoginEvent event, Emitter<RemoteAuthenticationState> emitter) async {
    emitter(RemoteAuthLoading());
    final request = LoginRequest(username: event.username, password: event.password);
    final dataState = await loginUseCase.invoke(params: request);
    if (dataState is Success) {
      final user = dataState.data;
      print(user);
      emitter(RemoteAuthSuccess(user: user));
    } else if (dataState is Failure) {
      final errorMessage = dataState.error;
      print(errorMessage);
      emitter(RemoteAuthFailure(errorMessage: errorMessage));
    }
  }
}