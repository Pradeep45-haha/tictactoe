import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/menu_screen.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/widgets/custom_button.dart';
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
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is PlayerLeftState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, MenuScreen.routeName);
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const PlayerScore(),
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,
                    child: TickTacToe(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                CustomButton(
                    onTap: () {
                      gameBloc.add(PlayerWantToLeaveEvent());
                    },
                    name: "Leave Room"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
