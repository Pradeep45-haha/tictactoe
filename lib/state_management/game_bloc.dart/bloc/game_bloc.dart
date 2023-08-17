import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:tictactoe/models/room.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/socket_methods.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  bool isTapListenerCalled = false;
  bool isLeaveRoomListenerCalled = false;
  int index = 0;

  SocketMethods socketMethods = SocketMethods();

  GameBloc({required this.gameRepository}) : super(GameInitial()) {
    on<GameEvent>(
      (event, emit) {
        if (event is PlayerGameDataFromServerEvent) {
          emit(
            PlayerGameDataFromServerState(),
          );
        }

        if (event is GameInitialEvent) {
          callback(data) {
            debugPrint("before emitTap: ${gameRepository.room.id}");

            index = data["index"];
            gameRepository.room = Room.fromMap(data["room"]);
            gameRepository.ticTacToeData[index] = data["choice"];
            debugPrint("player socket id logs");
            debugPrint("player 1 socket id${gameRepository.room.players[0].socketId}");
            debugPrint("player 2 socket id${gameRepository.room.players[1].socketId}");

            gameRepository.filledBoxes = gameRepository.filledBoxes + 1;

            add(
              PlayerGameDataFromServerEvent(),
            );
          }

          if (!isTapListenerCalled) {
            socketMethods.tapListener(callback);
            isTapListenerCalled = true;
          }
          callback2(data) {
            debugPrint(data.toString());
            add(PlayerLeaveSuccessEvent());
          }

          if (!isLeaveRoomListenerCalled) {
            socketMethods.leaveRoomListener(callback2);
          }
        }

        if (event is PlayerTappedEvent) {
          debugPrint("player tapped event detected in bloc");
          debugPrint("player tapped on index ${event.index}");
          debugPrint("player tapped on index ${gameRepository.ticTacToeData}");
          if (gameRepository.ticTacToeData[event.index] == "") {
            debugPrint("from game bloc tapGrid called");
            debugPrint(
                "roomId from payer event tapped ${gameRepository.room.id}");
            socketMethods.tapGrid(
              event.index,
              gameRepository.room.id,
            );
          }
        }
        if (event is PlayerWantToLeaveEvent) {
          debugPrint("player want to leave");
          socketMethods.leaveRoom(gameRepository.room.id);
        }
        if (event is PlayerLeaveSuccessEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          debugPrint("player left the game");
          emit(
            PlayerLeftState(),
          );
        }
      },
    );
  }
}
