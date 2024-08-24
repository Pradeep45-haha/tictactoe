part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}


class UserSignupEvent  extends SignupEvent{
  final String username;
  final String email;
  final String password;

  UserSignupEvent({required this.email, required this.password, required this.username});
}
