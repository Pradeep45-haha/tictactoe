import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/screens/menu_screen.dart';
import 'package:tictactoe/screens/waiting_lobby_screen.dart';
import 'package:tictactoe/state_management/create_room_bloc/bloc/create_room_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/state_management/join_room_bloc/bloc/join_room_bloc.dart';
import 'package:tictactoe/state_management/waiting_room_bloc/bloc/waiting_room_bloc.dart';
import 'package:tictactoe/utils/colors.dart';

void main() {
  GameRepository globalGameRepository = GameRepository(
    initilized: true,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateRoomBloc(
            gameRepository: globalGameRepository,
          ),
        ),
        BlocProvider(
          create: (context) => JoinRoomBloc(
            gameRepository: globalGameRepository,
          ),
        ),
        BlocProvider(
          create: (context) => GameBloc(
            gameRepository: globalGameRepository,
          ),
        ),
        BlocProvider(
          create: (context) => WaitingRoomBloc(
            gameRepository: globalGameRepository,
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
      },
      darkTheme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
      title: 'TicTacToe',
      debugShowCheckedModeBanner: false,
      initialRoute: MenuScreen.routeName,
    );
  }
}
