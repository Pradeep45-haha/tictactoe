import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/resources/auth_methods.dart';
import 'package:tictactoe/state_management/signup_bloc/bloc/signup_bloc.dart';
import 'package:tictactoe/utils/http_error_handler.dart';

import 'signup_bloc_test.mocks.dart';

@GenerateMocks([AuthMethods])
void main() {
  late MockAuthMethods mockAuthMethods;
  late SignupBloc signupBloc;

  setUp(() {
    mockAuthMethods = MockAuthMethods();
    signupBloc = SignupBloc(mockAuthMethods);
  });
  tearDown(() {
    signupBloc.close();
  });
  group("signup bloc testing", () {
    blocTest<SignupBloc, SignupState>(
      "state should be <UserSignupSuccessfulState>",
      build: () {
        when(mockAuthMethods.signup(
                email: anyNamed("email"),
                password: anyNamed("password"),
                username: anyNamed("username")))
            .thenAnswer((realInvocation) async {
          return Data(
              errorData: null, isError: false, successData: {"name": "name"});
        });
        return signupBloc;
      },
      act: (bloc) {
        return bloc.add(UserSignupEvent(
            email: "email", password: "password", username: "username"));
      },
      expect: () {
        return [isA<UserSignupSuccessfulState>()];
      },
    );

    blocTest<SignupBloc, SignupState>(
      "state should be <UserSignupFailedState>",
      build: () {
        when(mockAuthMethods.signup(
                email: anyNamed("email"),
                password: anyNamed("password"),
                username: anyNamed("username")))
            .thenAnswer((_) async {
          return Data(errorData: "failed", isError: true, successData: null);
        });
        return signupBloc;
      },
      act: (bloc) {
        return bloc.add(UserSignupEvent(
            email: "email", password: "password", username: "username"));
      },
      expect: () {
        return [isA<UserSignupFailedState>()];
      },
    );
  });
}
