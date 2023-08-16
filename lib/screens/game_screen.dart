import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/widgets/player_score.dart';
import 'package:tictactoe/widgets/tic_tac_toe.dart';

class GameScreen extends StatefulWidget {
  static String routeName = "/game";
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {      
    
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    gameBloc.add(GameInitialEvent());
    debugPrint(
        "from game screen gamebloc data${gameBloc.gameRepository.room.players[0].nickName}");
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PlayerScore(),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: TickTacToe(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
