import 'package:tictactoe/repository/game_repository.dart';

class Game {
  static bool checkWinner(
      {required GameRepository gameRepository, required String playerType}) {
    List<String> data = gameRepository.ticTacToeData;
    for (int i = 0; i < data.length; i += 3) {
      if (data[i] == playerType &&
          data[i + 1] == playerType &&
          data[i + 2] == playerType) {
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (data[i] == playerType &&
          data[i + 3] == playerType &&
          data[i + 6] == playerType) {
        return true;
      }
    }
    if (data[0] == playerType &&
        data[4] == playerType &&
        data[8] == playerType) {
      return true;
    }
    if (data[2] == playerType &&
        data[4] == playerType &&
        data[6] == playerType) {
      return true;
    }

    return false;
  }

  static bool checkDraw({
    required GameRepository gameRepository,
  }) {
    if (gameRepository.filledBoxes == 9) {
      return true;
    }
    return false;
  }
}
