
abstract class RemoteAuthenticationEvent {
  const RemoteAuthenticationEvent();
}

class LoginEvent extends RemoteAuthenticationEvent {
  String username;
  String password;

  LoginEvent({required this.username, required this.password});
}

class SignUpEvent extends RemoteAuthenticationEvent {
  String email;
  String password;

  SignUpEvent({required this.email, required this.password});
}