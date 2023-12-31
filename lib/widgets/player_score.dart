import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/utils/colors.dart';

class PlayerScore extends StatefulWidget {
  const PlayerScore({
    super.key,
  });

  @override
  State<PlayerScore> createState() => _PlayerScoreState();
}

class _PlayerScoreState extends State<PlayerScore> {
  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    const TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: glowColor,
    );
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Round ",
                    style: style.copyWith(),
                  ),
                  Text(
                    gameBloc.gameRepository.room.currentRound,
                    style: style.copyWith(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " /",
                    style: style,
                  ),
                  Text(
                    gameBloc.gameRepository.room.maxRound,
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
      },
    );
  }
}
