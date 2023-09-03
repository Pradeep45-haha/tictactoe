import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/room.dart';

class GameRepository {
  final bool initilized;
  GameRepository({
    required this.initilized,
  });

  //for game bloc
  int filledBoxes = 0;
  bool isGameDrawListenerCalled = false;
  bool isTapListenerCalled = false;
  bool isLeaveRoomListenerCalled = false;
  bool isWinnerListenerCalled = false;
  bool isMatchDrawListenerCalled = false;
  bool isDefeatListenerCalled = false;
  bool isNoPointsListenerCalled = false;
  bool isAddPointsListenerCalled = false;

  //for join room bloc
  bool isjoinRoomListenerCalled = false;

  //for create room bloc
  bool iscreateRoomSuccessListenerCalled = false;

  //for waiting room bloc
  bool isNewPlayerJoinedListenerCalled = false;

  Room room = Room(
    id: "",
    turn: Player(
      nickName: "",
      socketId: "",
      matchWon: "",
      playerType: "",
      id: "",
    ),
    occupancy: "",
    maxRound: "",
    currentRound: "",
    isJoin: "",
    players: [],
    version: "",
    turnIndex: "",
  );

  List<String> ticTacToeData = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
}
