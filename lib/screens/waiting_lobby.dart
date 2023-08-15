import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/state_management/game_bloc.dart/bloc/game_bloc.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import '../utils/colors.dart';
import '../widgets/shadow_text.dart';

class WaitingScreen extends StatelessWidget {
  static String routeName = "/waiting-room";
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is NewPlayerJoinedState) {
          Navigator.of(context).pushNamed(GameScreen.routeName);
        }
      },
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          gameBloc.add(GameInitialEvent());
          if(state is NewPlayerJoinedState)
          {
             WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(
                        context,
                        GameScreen.routeName,
                      );
                    });
          }
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ShadowText(
                    fontSize: 30,
                    glowColor: glowColor,
                    shadows: [
                      Shadow(
                        color: Colors.greenAccent,
                        blurRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                    text: "Waiting For Other Player",
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const CircularProgressIndicator(
                    color: glowColor,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomTextField(
                      isReadOnly: true,
                      hintText: "",
                      textAlignment: TextAlign.center,
                      textEditingController: TextEditingController(
                        text: "Room ID : ${gameBloc.gameRepository.room.id}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
