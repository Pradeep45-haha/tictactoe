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
                    playerType: gameRepository.room.turn.playerType == "O"
                        ? "X"
                        : "O") ==
                true) {
              debugPrint("winner socket methos called");
              socketMethods.winner(
                  gameRepository.room.id, gameRepository.room.turn.playerType);
            }
            if (Game.checkDraw(gameRepository: gameRepository)) {
              debugPrint("draw socket methos called");
              socketMethods.draw(
                gameRepository.room.id,
              );
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
            gameRepository.room = Room.fromMap(data);
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

          gameDrawCallback(data) {
            add(GameDrawEvent());
          }

          if (!gameRepository.isTapListenerCalled) {
            socketMethods.tapListener(tapCallback);
            gameRepository.isTapListenerCalled = true;
          }

          if (!gameRepository.isLeaveRoomListenerCalled) {
            socketMethods.leaveRoomListener(leaveRoomCallback);
            gameRepository.isLeaveRoomListenerCalled = true;
          }

          if (!gameRepository.isWinnerListenerCalled) {
            socketMethods.winnerListener(winnerCallback);
            gameRepository.isWinnerListenerCalled = true;
          }
          if (!gameRepository.isDefeatListenerCalled) {
            socketMethods.defeatListener(defeatCallback);
            gameRepository.isDefeatListenerCalled = true;
          }

          if (!gameRepository.isMatchDrawListenerCalled) {
            socketMethods.matchDrawListener(drawCallback);
            gameRepository.isMatchDrawListenerCalled = true;
          }
          if (!gameRepository.isNoPointsListenerCalled) {
            socketMethods.noPointsListener(noPointsCallback);
            gameRepository.isNoPointsListenerCalled = true;
          }
          if (!gameRepository.isAddPointsListenerCalled) {
            socketMethods.addPointsListener(addPointsCallback);
            gameRepository.isAddPointsListenerCalled = true;
          }
          if (!gameRepository.isGameDrawListenerCalled) {
            socketMethods.gameDrawListener(gameDrawCallback);
            gameRepository.isGameDrawListenerCalled = true;
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
          socketMethods.disconnect();
          gameRepository.isTapListenerCalled = false;
          gameRepository.isLeaveRoomListenerCalled = false;
          gameRepository.isWinnerListenerCalled = false;
          gameRepository.isMatchDrawListenerCalled = false;
          gameRepository.isDefeatListenerCalled = false;
          gameRepository.isNoPointsListenerCalled = false;
          gameRepository.isAddPointsListenerCalled = false;
          gameRepository.iscreateRoomSuccessListenerCalled = false;
          gameRepository.isjoinRoomListenerCalled = false;
          gameRepository.isNewPlayerJoinedListenerCalled = false;

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
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(PlayerDefeatedState());
        }
        if (event is PlayerWonEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(PlayerWonState());
        }
        if (event is GameDrawEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(GameDrawState());
        }
        if (event is PlayerDrawEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(PlayerDrawState());
        }
        if (event is PlayerPointEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(PlayerPointState());
        }
        if (event is PlayerNoPointEvent) {
          gameRepository.ticTacToeData = gameRepository.ticTacToeData.map(
            (_) {
              return "";
            },
          ).toList();
          gameRepository.filledBoxes = 0;
          index = 0;
          emit(PlayerNoPointState());
        }

        //--------------------------------------------------------//
      },
    );
  }
}
