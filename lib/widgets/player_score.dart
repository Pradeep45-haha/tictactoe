import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/utils/colors.dart';

class PlayerScore extends StatelessWidget {
  const PlayerScore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    const TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: glowColor,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gameBloc.gameRepository.room.players[0].nickName,
                style: style,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                gameBloc.gameRepository.room.players[0].matchWon,
                style: style,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                gameBloc.gameRepository.room.players[1].nickName,
                style: style,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                gameBloc.gameRepository.room.players[1].matchWon,
                style: style,
              ),
            ],
          ),
        )
      ],
    );
  }
}
