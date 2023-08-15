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
  bool tapGridListner = false;
  final GameRepository gameRepository;
  int index = 0;

  SocketMethods socketMethods = SocketMethods();

  GameBloc({required this.gameRepository}) : super(GameInitial()) {
    on<GameEvent>(
      (event, emit) {
        if (event is GameInitialEvent) {
          debugPrint("game initial event running");

          callback(dynamic data) {
            gameRepository.room = Room.fromMap(data);
            add(
              NewPlayerJoinedEvent(),
            );
          }

          socketMethods.newPlayerJoined(callback);
        }
        if (event is NewPlayerJoinedEvent) {
          emit(NewPlayerJoinedState());
        }
        if (event is PlayerTappedEvent) {
          socketMethods.tapGrid(event.index, gameRepository.room.id,
              gameRepository.ticTacToeData);
          if (tapGridListner) {
            return;
          }
          callback(data) {
            debugPrint("from game bloc $data");
            index = data["index"];
            gameRepository.room = Room.fromMap(data["room"]);
            gameRepository.ticTacToeData[index] = data["choice"];
            gameRepository.filledBoxes = gameRepository.filledBoxes + 1;

            add(
              PlayerGameDataFromServerEvent(),
            );
          }

          socketMethods.tapListener(callback);
          tapGridListner = true;
        }
        if (event is PlayerGameDataFromServerEvent) {
          emit(
            PlayerGameDataFromServerState(),
          );
        }
      },
    );
  }
}
