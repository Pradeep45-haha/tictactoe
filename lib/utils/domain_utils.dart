import 'package:flutter/material.dart';
import 'package:tictactoe/repository/game_repository.dart';

class Game {
  static bool checkWinner(
      {required GameRepository gameRepository, required String playerType}) {
    debugPrint("from check winner player type is $playerType");
    debugPrint("check winner is running");
    List<String> data = gameRepository.ticTacToeData;
    for (int i = 0; i < data.length; i += 3) {
      //debugPrint(i.toString());
      //debugPrint(
      //"data 1: ${data[i]} , data 2 :${data[i + 1]} , data3 : ${data[i + 2]}");
      if (data[i] == playerType &&
          data[i + 1] == playerType &&
          data[i + 2] == playerType) {
        //debugPrint(" 1 check winner :true");
        return true;
      }
    }

    for (int i = 0; i < 3; i++) {
      //debugPrint(
      // "data 1: ${data[i]} , data 2 :${data[i + 3]} , data3 : ${data[i + 6]}");
      if (data[i] == playerType &&
          data[i + 3] == playerType &&
          data[i + 6] == playerType) {
        //debugPrint("2 check winner :true");
        return true;
      }
    }
    if (data[0] == playerType &&
        data[4] == playerType &&
        data[8] == playerType) {
      //debugPrint("3 check winner :true");
      return true;
    }
    if (data[2] == playerType &&
        data[4] == playerType &&
        data[6] == playerType) {
      //debugPrint("4 check winner :true");
      return true;
    }
    //debugPrint("check winner :false");
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
