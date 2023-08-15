import 'package:flutter/material.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/widgets/custom_button.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = '/menu-screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CreateRoomScreen.routeName,
                );
              },
              name: "Create Room",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () {
                 Navigator.of(context).pushNamed(
                  JoinRoomScreen.routeName,
                );
              },
              name: "Join Room",
            )
          ],
        ),
      ),
    );
  }
}
