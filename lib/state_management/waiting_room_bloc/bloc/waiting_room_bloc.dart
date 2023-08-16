import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/socket_methods.dart';

import '../../../models/room.dart';

part 'waiting_room_event.dart';
part 'waiting_room_state.dart';

class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  bool isNewPlayerJoinedListenerCalled = false;
  final GameRepository gameRepository;
  SocketMethods socketMethods = SocketMethods();

  WaitingRoomBloc({required this.gameRepository})
      : super(WaitingRoomInitial()) {
    on<WaitingRoomEvent>((event, emit) {
      if (event is WaitingRoomInitialEvent) {
        debugPrint("game initial event running");

        callback(dynamic data) {
          debugPrint("new player joined callback executed");
          gameRepository.room = Room.fromMap(data);
          add(NewPlayerJoinedEvent(),);
          debugPrint("new player joined callback executed near end");
        }

        if (!isNewPlayerJoinedListenerCalled) {
          debugPrint("new player joined listener called");
          socketMethods.newPlayerJoinedListener(callback);
          isNewPlayerJoinedListenerCalled = true;
        }
      }
      

      if (event is NewPlayerJoinedEvent) {
        debugPrint("new player joined event detected");
        emit(NewPlayerJoinedState());
      }
    });
  }
}
