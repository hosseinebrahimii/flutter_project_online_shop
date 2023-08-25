import 'package:dartz/dartz.dart';

abstract class AuthenticationState {}

class AuthenticationInitiateState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationResponseState extends AuthenticationState {
  final Either<String, String> response;
  AuthenticationResponseState(this.response);
}
