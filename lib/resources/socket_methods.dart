import 'package:flutter/foundation.dart';
import 'package:tictactoe/resources/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance;
  
  void createRoom(String nickName) {
    //print(_socketClient.socket!.connected);
    if (nickName.isNotEmpty) {
      _socketClient.socket!.emit(
        "createRoom",
        {"roomName": nickName},
      );
    }
  }

  void createRoomSuccessListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("createRoomSuccess", callback);
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.socket!.emit(
        "joinRoom",
        {
          "nickName": nickName,
          "roomId": roomId,
        },
      );
    }
  }

  void tapGrid(int index, String roomId, List<String> ticTacToeData) {
    debugPrint("from socket method tapGrid");
    if (ticTacToeData[index] == "") {
      _socketClient.socket!.emit("boardTap", {
        "index": index,
        "roomId": roomId,
      });
    }
  }

  void newPlayerJoinedListener(Function(dynamic) callback) async {
    
    _socketClient.socket!.on("newPlayerJoined", callback);
  }

  void joinRoomSuccessListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("joinRoomSuccess", callback);
  }

  void joinRoomFailureListener(Function(dynamic) callback) async {
    
    _socketClient.socket!.on("joinRoomError", callback);
  }

  void tapListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("tapped", callback);
  }
}
