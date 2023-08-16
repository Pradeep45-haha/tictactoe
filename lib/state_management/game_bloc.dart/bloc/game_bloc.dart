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
  int index = 0;

  SocketMethods socketMethods = SocketMethods();

  GameBloc({required this.gameRepository}) : super(GameInitial()) {
    on<GameEvent>(
      (event, emit) {
        callback(data) {
          debugPrint("game initial callback running");
          //debugPrint("from game bloc $data");
          index = data["index"];
          gameRepository.room = Room.fromMap(data["room"]);
          gameRepository.ticTacToeData[index] = data["choice"];
          gameRepository.filledBoxes = gameRepository.filledBoxes + 1;

          add(
            PlayerGameDataFromServerEvent(),
          );
        }

        if (event is PlayerGameDataFromServerEvent) {
          emit(
            PlayerGameDataFromServerState(),
          );
        }

        if (event is GameInitialEvent) {
          if (!isTapListenerCalled) {
            socketMethods.tapListener(callback);
            isTapListenerCalled = true;
          }
        }

        if (event is PlayerTappedEvent) {
          debugPrint("player tapped event detected in bloc");
          socketMethods.tapGrid(event.index, gameRepository.room.id,
              gameRepository.ticTacToeData);
        }
      },
    );
  }
}
