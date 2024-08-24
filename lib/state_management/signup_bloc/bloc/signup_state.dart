part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class UserSignupSuccessfulState extends SignupState {}

class UserSignupFailedState extends SignupState {
  final String errorMsg;
  UserSignupFailedState({required this.errorMsg});
}
