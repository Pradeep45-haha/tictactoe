import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:tictactoe/models/room.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/socket_methods.dart';
part 'join_room_event.dart';
part 'join_room_state.dart';

class JoinRoomBloc extends Bloc<JoinRoomEvent, JoinRoomState> {
  final GameRepository gameRepository;
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomIdController = TextEditingController();
  String roomName = "";
  String roomId = "";
  SocketMethods socketMethods = SocketMethods();

  @override
  Future<void> close() {
    roomNameController.dispose();
    return super.close();
  }

  JoinRoomBloc({required this.gameRepository}) : super(JoinRoomInitial()) {
    debugPrint("Join Bloc Room instantiated");
    on<JoinRoomEvent>(
      (event, emit) {
        if (event is JoinRoomNameChangedEvent) {
          roomName = roomNameController.text;
          //print("nick name is $roomName");
        }
        if (event is JoinRoomIdChangedEvent) {
          roomId = roomIdController.text;
          // print("room id is $roomId");
        }
        if (event is JoinRoomButtonPressed) {
          socketMethods.connect();
          debugPrint("Join room called");
          socketMethods.joinRoom(
            roomNameController.text,
            roomIdController.text,
          );
          if (gameRepository.isjoinRoomListenerCalled == true) {
            return;
          }
          callbackSuccess(dynamic data) {
            debugPrint("join room success");
            gameRepository.room = Room.fromMap(data);
            add(
              JoinRoomSuccessDataFromServerEvent(),
            );
          }

          callbackFailure(dynamic data) {
            debugPrint("join room failure");

            debugPrint(data.toString());
            add(
              JoinRoomFailureDataFromServerEvent(),
            );
          }

          socketMethods.joinRoomSuccessListener(callbackSuccess);
          socketMethods.joinRoomFailureListener(callbackFailure);
          gameRepository.isjoinRoomListenerCalled = true;
        }
        if (event is JoinRoomSuccessDataFromServerEvent) {
          debugPrint("join Success");
          emit(JoinRoomSuccessState());
        }
        if (event is JoinRoomFailureDataFromServerEvent) {
          debugPrint("join failure");
          emit(
            JoinRoomFailureState(),
          );
        }
      },
    );
  }
}
