import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/auth_methods.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/screens/login_screen.dart';
import 'package:tictactoe/screens/menu_screen.dart';
import 'package:tictactoe/screens/signup_screen.dart';
import 'package:tictactoe/screens/waiting_lobby_screen.dart';
import 'package:tictactoe/state_management/create_room_bloc/bloc/create_room_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/state_management/join_room_bloc/bloc/join_room_bloc.dart';
import 'package:tictactoe/state_management/login_bloc/bloc/login_bloc.dart';
import 'package:tictactoe/state_management/signup_bloc/bloc/signup_bloc.dart';
import 'package:tictactoe/state_management/waiting_room_bloc/bloc/waiting_room_bloc.dart';
import 'package:tictactoe/utils/colors.dart';

void main() {
  GameRepository globalGameRepository = GameRepository(
    initilized: true,
  );
  Client client = Client();
  AuthMethods authMethods = AuthMethods(client: client);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateRoomBloc(
              gameRepository: globalGameRepository,
              socketMethods:
                  SocketMethods(token: globalGameRepository.authToken ?? "")),
        ),
        BlocProvider(
          create: (context) => JoinRoomBloc(
              gameRepository: globalGameRepository,
              socketMethods:
                  SocketMethods(token: globalGameRepository.authToken ?? "")),
        ),
        BlocProvider(
          create: (context) => GameBloc(
              gameRepository: globalGameRepository,
              socketMethods:
                  SocketMethods(token: globalGameRepository.authToken ?? "")),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
              authMethods: authMethods, gameRepository: globalGameRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(authMethods),
        ),
        BlocProvider(
          create: (context) => WaitingRoomBloc(
            gameRepository: globalGameRepository,
            socketMethods:
                SocketMethods(token: globalGameRepository.authToken ?? ""),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MenuScreen.routeName: (context) => const MenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
        WaitingScreen.routeName: (context) => const WaitingScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
      darkTheme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
      title: 'TicTacToe',
      debugShowCheckedModeBanner: false,
      initialRoute: SignupScreen.routeName,
    );
  }
}
