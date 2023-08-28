import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/room.dart';

class GameRepository {
  final bool initilized;
  GameRepository({
    required this.initilized,
  });
  //final List<Map<String, dynamic>> errorListMap = [];
  int filledBoxes = 0;

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
