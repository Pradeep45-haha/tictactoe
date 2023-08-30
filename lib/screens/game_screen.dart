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
            Navigator.of(context).pushNamedAndRemoveUntil(
              MenuScreen.routeName,
              (Route<dynamic> route) => false,
            );
          });
        }
        if (state is PlayerNoPointState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              elevation: 5,
              backgroundColor: Color.fromARGB(255, 63, 14, 71),
              duration: Duration(seconds: 2, milliseconds: 500),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(
                      20,
                    )),
              ),
              showCloseIcon: true,
              content: Text(
                "Defeat",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (state is PlayerPointState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              showCloseIcon: true,
              backgroundColor: Color.fromARGB(255, 63, 14, 71),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(
                      20,
                    )),
              ),
              duration: Duration(seconds: 2, milliseconds: 500),
              content: Text(
                "You Won",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          );
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
