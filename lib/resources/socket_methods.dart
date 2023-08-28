import 'package:flutter/foundation.dart';
import 'package:tictactoe/resources/socket_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance;

  get socketClient {
    return _socketClient;
  }

  String getSocketClientId() {
    return _socketClient.socket!.id!;
  }

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient.socket!.emit(
        "createRoom",
        {"roomName": nickName},
      );
    }
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

  void leaveRoom(String roomId) {
    _socketClient.socket!.emit("leaveRoom", {
      "roomId": roomId,
    });
  }

  void tapGrid(int index, String roomId) {
    debugPrint("from socket method tapGrid");
    debugPrint("socket connection status ${_socketClient.socket!.connected}");
    _socketClient.socket!.emit("boardTap", {
      "index": index,
      "roomId": roomId,
    });
  }

  // void addPoints(String roomId, String playerType) {
  //   _socketClient.socket!.emit("addPoints", {
  //     "roomId": roomId,
  //     "playerType": playerType,
  //   });
  // }

  void winner(String roomId, String playerType) {
    _socketClient.socket!.emit("winner", {
      "roomId": roomId,
      "playerType": playerType,
    });
  }

  void draw(String roomId) {
    _socketClient.socket!.emit("draw", {
      "roomId": roomId,
    });
  }

  void createRoomSuccessListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("createRoomSuccess", callback);
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

  void leaveRoomListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("playerLeft", callback);
  }

  void addPointsListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("addPoints", callback);
  }

  void noPointsListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("noPoints", callback);
  }

  void winnerListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("playerWon", callback);
  }

  void defeatListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("playerDefeated", callback);
  }

  void drawListener(Function(dynamic) callback) async {
    _socketClient.socket!.on("draw", callback);
  }
}
