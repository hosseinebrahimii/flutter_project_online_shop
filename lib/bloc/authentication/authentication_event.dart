abstract class AuthenticationEvent {}

class AuthenticationLoginRequestEvent extends AuthenticationEvent {
  String username;
  String password;

  AuthenticationLoginRequestEvent(this.username, this.password);
}
