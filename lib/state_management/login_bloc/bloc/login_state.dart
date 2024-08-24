part of 'login_bloc.dart';

@immutable
class LoginState {}

final class LoginInitial extends LoginState {}

class UserLoginFailedState extends LoginState {
  final String errorMsg;
  UserLoginFailedState({required this.errorMsg});
}


class UserLoggedInState extends LoginState {
  final String token;
  UserLoggedInState({required this.token});
}