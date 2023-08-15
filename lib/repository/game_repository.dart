import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/room.dart';

class GameRepository {
  
  final bool initilized;
  GameRepository({
    required this.initilized,
  });
  final List<Map<String, dynamic>> errorListMap = [];
  int filledBoxes = 0;
  Player player1 = Player(
    nickName: "",
    socketId: "",
    matchWon: "",
    playerType: "",
    id: "",
  );
  Player player2 = Player(
    nickName: "",
    socketId: "",
    matchWon: "",
    playerType: "",
    id: "",
  );

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
  String name = "tictactoe";
}
