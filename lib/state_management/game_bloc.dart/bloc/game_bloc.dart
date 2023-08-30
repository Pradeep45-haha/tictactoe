import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:tictactoe/models/room.dart';
import 'package:tictactoe/repository/game_repository.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/domain_utils.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;
  bool isTapListenerCalled = false;
  bool isLeaveRoomListenerCalled = false;
  bool isWinnerListenerCalled = false;
  bool isDrawListenerCalled = false;
  bool isDefeatListenerCalled = false;
  bool isNoPointsListenerCalled = false;
  bool isAddPointsListenerCalled = false;
  int index = 0;

  SocketMethods socketMethods = SocketMethods();

  GameBloc({required this.gameRepository}) : super(GameInitial()) {
    on<GameEvent>(
      (event, emit) {
        if (event is PlayerGameDataFromServerEvent) {
          if (gameRepository.room.turn.socketId !=
              socketMethods.getSocketClientId()) {
            if (Game.checkWinner(
                gameRepository: gameRepository,
                playerType:
                    gameRepository.room.turn.playerType == "O" ? "X" : "O")) {
              debugPrint("winner socket methos called");
              socketMethods.winner(
                  gameRepository.room.id, gameRepository.room.turn.playerType);
            } else {
              if (Game.checkDraw(gameRepository: gameRepository)) {
                debugPrint("draw socket methos called");
                socketMethods.draw(
                  gameRepository.room.id,
                );
              }
            }
          }

          emit(
            PlayerGameDataFromServerState(),
          );
        }

        if (event is GameInitialEvent) {
          tapCallback(data) {
            index = data["index"];
            gameRepository.room = Room.fromMap(data["room"]);
            gameRepository.ticTacToeData[index] = data["choice"];

            gameRepository.filledBoxes = gameRepository.filledBoxes + 1;

            add(
              PlayerGameDataFromServerEvent(),
            );
          }

          leaveRoomCallback(data) {
            add(PlayerLeaveSuccessEvent());
          }

          winnerCallback(data) {
            add(PlayerWonEvent());
            return;
          }

          defeatCallback(data) {
            add(PlayerDefeatedEvent());
            return;
          }

          drawCallback(data) {
            add(PlayerDrawEvent());
            return;
          }

          noPointsCallback(data) {
            gameRepository.room = Room.fromMap(data);

            debugPrint(
                "from no points ${gameRepository.room.players[0].matchWon}");
            debugPrint(
                "from no points ${gameRepository.room.players[1].matchWon}");
            add(PlayerNoPointEvent());
          }

          addPointsCallback(data) {
            gameRepository.room = Room.fromMap(data);
            debugPrint(
                "from add points ${gameRepository.room.players[0].matchWon}");
            debugPrint(
                "from add points ${gameRepository.room.players[1].matchWon}");
            add(PlayerPointEvent());
          }

          if (!isTapListenerCalled) {
            socketMethods.tapListener(tapCallback);
            isTapListenerCalled = true;
          }

          if (!isLeaveRoomListenerCalled) {
            socketMethods.leaveRoomListener(leaveRoomCallback);
          }

          if (!isWinnerListenerCalled) {
            socketMethods.winnerListener(winnerCallback);
            isWinnerListenerCalled = true;
          }
          if (!isDefeatListenerCalled) {
            socketMethods.defeatListener(defeatCallback);
            isDefeatListenerCalled = true;
          }

          if (!isDrawListenerCalled) {
            socketMethods.drawListener(drawCallback);
            isDrawListenerCalled = true;
          }
          if (!isNoPointsListenerCalled) {
            socketMethods.noPointsListener(noPointsCallback);
          }
          if (!isAddPointsListenerCalled) {
            socketMethods.addPointsListener(addPointsCallback);
          }
        }

        if (event is PlayerTappedEvent) {
          if (gameRepository.ticTacToeData[event.index] == "") {
            socketMethods.tapGrid(
              event.index,
              gameRepository.room.id,
            );
          }
        }
        if (event is PlayerWantToLeaveEvent) {
          socketMethods.leaveRoom(gameRepository.room.id);
        }
        if (event is PlayerLeaveSuccessEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();

          emit(
            PlayerLeftState(),
          );
        }

        if (event is PlayerDefeatedEvent) {
          emit(PlayerDefeatedState());
        }
        if (event is PlayerWonEvent) {
          emit(PlayerWonState());
        }
        if (event is PlayerDrawEvent) {
          emit(PlayerDrawState());
        }
        if (event is PlayerPointEvent) {
          emit(PlayerPointState());
        }
        if (event is PlayerNoPointEvent) {
          emit(PlayerNoPointState());
        }

        //--------------------------------------------------------//
      },
    );
  }
}
