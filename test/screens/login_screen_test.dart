import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tictactoe/state_management/login_bloc/bloc/login_bloc.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class LoginStateFake extends Fake implements LoginState {}

class LoginEventFake extends Fake implements LoginEvent {}

void main() {
  setUpAll(() {});

  testWidgets('Login screen testing', (tester) async {
    // final mockLoginBloc = MockLoginBloc();
  });
}
