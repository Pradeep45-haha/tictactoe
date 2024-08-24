import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:tictactoe/resources/auth_methods.dart';
import 'package:tictactoe/utils/http_error_handler.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthMethods _authMethods;
  SignupBloc(this._authMethods) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is UserSignupEvent) {
        Data data = await _authMethods.signup(
            email: event.email,
            password: event.password,
            username: event.username);
        if (data.isError) {
          emit(UserSignupFailedState(errorMsg: data.errorData! as String));
          return;
        }
        emit(UserSignupSuccessfulState());
        return;
      }
    });
  }
}
