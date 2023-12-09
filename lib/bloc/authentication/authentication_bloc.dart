import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_event.dart';
import 'package:flutter_project_online_shop/bloc/authentication/authentication_state.dart';
import 'package:flutter_project_online_shop/data/repository/authentication_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _repository;

  AuthenticationBloc(this._repository) : super(AuthenticationInitiateState()) {
    on<AuthenticationLoginRequestEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());
        var response = await _repository.repositoryLogin(event.username, event.password);
        emit(AuthenticationResponseState(response));
      },
    );

    on<AuthenticationRegisterRequestEvent>(
      (event, emit) async {
        emit(AuthenticationLoadingState());
        var registerResponse = await _repository.repositoryRegister(
          event.username,
          event.password,
          event.passwordConfirm,
        );
        var loginResponse = await _repository.repositoryLogin(
          event.username,
          event.password,
        );

        Either<String, String> response() {
          return registerResponse.fold(
            (registerError) => left(registerError),
            (registerSuccess) => loginResponse.fold(
              (loginError) => left(loginError),
              (token) => right(token),
            ),
          );
        }

        emit(AuthenticationResponseState(response()));
      },
    );
  }
}
