import 'package:flutter/material.dart';
import 'package:tictactoe/repository/game_repository.dart';

class Game {
  static bool checkWinner(
      {required GameRepository gameRepository, required String playerType}) {
    debugPrint("from check winner player type is $playerType");
    debugPrint("check winner is running");
    List<String> data = gameRepository.ticTacToeData;
    for (int i = 0; i < data.length; i += 3) {
      if (data[i] == playerType &&
          data[i + 1] == playerType &&
          data[i + 2] == playerType) {
        debugPrint("true from 1st checkWinner, horizontal");
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (data[i] == playerType &&
          data[i + 3] == playerType &&
          data[i + 6] == playerType) {
        debugPrint("true from 2nd checkWinner, vertical");
        return true;
      }
    }
    if (data[0] == playerType &&
        data[4] == playerType &&
        data[8] == playerType) {
      debugPrint("true from 3rd checkWinner, lft->rht diagonal");
      return true;
    }
    if (data[2] == playerType &&
        data[4] == playerType &&
        data[6] == playerType) {
      debugPrint("true from 3rd checkWinner, rht->lft diagonal");
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
