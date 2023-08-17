import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';

class TickTacToe extends StatefulWidget {
  const TickTacToe({super.key});

  @override
  State<TickTacToe> createState() => _TickTacToeState();
}

class _TickTacToeState extends State<TickTacToe> {
  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      return GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              debugPrint("player tapped event added");
              gameBloc.add(
                PlayerTappedEvent(
                  index: index,
                ),
              );
            },
            child: AbsorbPointer(
              absorbing: gameBloc.gameRepository.room.turn.socketId !=
                  gameBloc.socketMethods.getSocketClientId(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                ),
                child: Center(
                  child: Text(
                    gameBloc.gameRepository.ticTacToeData[index],
                    style: TextStyle(
                      color: gameBloc.gameRepository.ticTacToeData[index] == "O"
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      shadows: const [
                        Shadow(
                          color: Colors.blue,
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
