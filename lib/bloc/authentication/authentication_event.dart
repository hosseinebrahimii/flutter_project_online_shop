abstract class AuthenticationEvent {}

class AuthenticationLoginRequestEvent extends AuthenticationEvent {
  String username;
  String password;

  AuthenticationLoginRequestEvent(
    this.username,
    this.password,
  );
}

class AuthenticationRegisterRequestEvent extends AuthenticationEvent {
  String username;
  String password;
  String passwordConfirm;

  AuthenticationRegisterRequestEvent(
    this.username,
    this.password,
    this.passwordConfirm,
  );
}
