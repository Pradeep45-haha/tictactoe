import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/state_management/waiting_room_bloc/bloc/waiting_room_bloc.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import '../utils/colors.dart';
import '../widgets/shadow_text.dart';

class WaitingScreen extends StatelessWidget {
  static String routeName = "/waiting-room";
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WaitingRoomBloc waitingRoomBloc = BlocProvider.of<WaitingRoomBloc>(context);
    waitingRoomBloc.add(WaitingRoomInitialEvent());
    return BlocListener<WaitingRoomBloc, WaitingRoomState>(
      listener: (context, state) {
        if (state is NewPlayerJoinedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, GameScreen.routeName);
          });
        }
      },
      child: Scaffold(
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
                    text: "Room ID : ${waitingRoomBloc.gameRepository.room.id}",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
