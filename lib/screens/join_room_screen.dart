import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/state_management/join_room_bloc/bloc/join_room_bloc.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glowing_text.dart';
import 'game_screen.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = "/join-room";
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    JoinRoomBloc joinRoomBloc = BlocProvider.of<JoinRoomBloc>(context);
    return BlocListener<JoinRoomBloc, JoinRoomState>(
      listener: (context, state) {
        if (state is JoinRoomSuccessState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, GameScreen.routeName);
          });
        }
        if (state is JoinRoomFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Cannot Join Game",
              ),
              backgroundColor: glowColor,
              duration: Duration(
                seconds: 1,
                milliseconds: 500,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GlowingText(
                  text: "Join Room",
                  fontSize: 70,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: glowColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                CustomTextField(
                  onChanged: (p0) {
                    joinRoomBloc.add(
                      JoinRoomNameChangedEvent(),
                    );
                  },
                  hintText: "Enter nick name",
                  textEditingController: joinRoomBloc.roomNameController,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                CustomTextField(
                  onChanged: (p0) {
                    joinRoomBloc.add(
                      JoinRoomIdChangedEvent(),
                    );
                  },
                  hintText: "Enter room id",
                  textEditingController: joinRoomBloc.roomIdController,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                CustomButton(
                  onTap: () {
                    joinRoomBloc.add(
                      JoinRoomButtonPressed(
                        nickName: joinRoomBloc.roomNameController.text,
                        roomId: joinRoomBloc.roomIdController.text,
                      ),
                    );
                  },
                  name: "Join",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
