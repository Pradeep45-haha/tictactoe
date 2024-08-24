import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/screens/waiting_lobby_screen.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import 'package:tictactoe/widgets/glowing_text.dart';
import '../state_management/create_room_bloc/bloc/create_room_bloc.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = "/create-room";
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    CreateRoomBloc createRoomBloc = BlocProvider.of<CreateRoomBloc>(context);
    double height = MediaQuery.of(context).size.height;
    return BlocListener<CreateRoomBloc, CreateRoomState>(
      bloc: createRoomBloc,
      listener: (context, state) {
        if (state is CreateRoomSuccessState) {
          debugPrint("waiting room pushed");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(
              context,
              WaitingScreen.routeName,
            );
          });
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
                  text: "Create Room",
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
                    createRoomBloc.add(CreateRoomNameChangedEvent());
                  },
                  hintText: "Enter nick name",
                  textEditingController: createRoomBloc.roomNameController,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                CustomButton(
                  onTap: () {
                    createRoomBloc.add(
                      CreateRoomWithNameEvent(
                        roomName: createRoomBloc.roomNameController.text,
                      ),
                    );
                  },
                  name: "Create",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
