import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:tictactoe/models/room.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/socket_methods.dart';
part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final GameRepository gameRepository;
  TextEditingController roomNameController = TextEditingController();
  final SocketMethods socketMethods;

  @override
  Future<void> close() {
    debugPrint("closed called");
    roomNameController.dispose();
    return super.close();
  }

  CreateRoomBloc({required this.gameRepository, required this.socketMethods})
      : super(CreateRoomInitial()) {
    on<CreateRoomEvent>((event, emit) async {
      if (event is CreateRoomWithNameEvent) {
        socketMethods.connect();
        socketMethods.createRoom(roomNameController.text);
        callback(dynamic data) async {
          gameRepository.room = Room.fromMap(data);
          add(CreateRoomSuccessEvent());
        }

        if (!gameRepository.iscreateRoomSuccessListenerCalled) {
          socketMethods.createRoomSuccessListener(callback);
          gameRepository.iscreateRoomSuccessListenerCalled = true;
        }
      }
      if (event is CreateRoomSuccessEvent) {
        emit(CreateRoomSuccessState());
      }
    });
  }
}
