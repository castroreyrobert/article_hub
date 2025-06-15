
abstract class RemoteAuthenticationEvent {
  const RemoteAuthenticationEvent();
}

class LoginEvent extends RemoteAuthenticationEvent {
  String email;
  String password;

  LoginEvent({required this.email, required this.password});
}