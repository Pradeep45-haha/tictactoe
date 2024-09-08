// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:tictactoe/repository/game_repository.dart';
// import 'package:tictactoe/resources/auth_methods.dart';
// import 'package:tictactoe/state_management/login_bloc/bloc/login_bloc.dart';
// import 'package:tictactoe/utils/http_error_handler.dart';

// import 'login_bloc_test.mocks.dart';

// // @GenerateMocks([Client])
// @GenerateMocks([AuthMethods])
// @GenerateMocks([GameRepository])
// void main() {
//   late MockAuthMethods mockAuthMethods;
//   late MockGameRepository mockGameRepository;
//   late LoginBloc loginBloc;

//   setUp(() {
//     mockAuthMethods = MockAuthMethods();
//     loginBloc = LoginBloc(
//         authMethods: mockAuthMethods, gameRepository: mockGameRepository);
//   });

//   tearDown(() {
//     loginBloc.close();
//   });

//   group('LoginBloc Tests', () {
//     blocTest<LoginBloc, LoginState>(
//       'emits [UserLoginFailedState] when login fails',
//       build: () {
//         when(mockAuthMethods.login(
//                 email: anyNamed('email'), password: anyNamed('password')))
//             .thenAnswer((_) async => Data(
//                 isError: true, errorData: 'Login Failed', successData: null));
//         return loginBloc;
//       },
//       act: (bloc) => bloc
//           .add(UserLoginEvent(email: 'test@example.com', password: 'password')),
//       expect: () => [isA<UserLoginFailedState>()],
//     );

//     blocTest<LoginBloc, LoginState>(
//       'emits [UserLoggedInState] when login is successful',
//       build: () {
//         when(mockAuthMethods.login(
//                 email: anyNamed('email'), password: anyNamed('password')))
//             .thenAnswer((_) async => Data(
//                 isError: false,
//                 successData: {'token': '123'},
//                 errorData: null));
//         return loginBloc;
//       },
//       act: (bloc) => bloc
//           .add(UserLoginEvent(email: 'test@example.com', password: 'password')),
//       expect: () => [isA<UserLoggedInState>()],
//     );
//   });
// }
