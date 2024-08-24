import 'package:flutter/foundation.dart';
import 'package:tictactoe/resources/socket_client.dart';

class SocketMethods {
  final String token;

  SocketMethods({
    required this.token,
  });

  get getsocketClient {
    return SocketClient.getInstance(token);
  }

  String? getSocketClientId() {
    return getsocketClient.socket?.id;
  }

  void disconnect() {
    getsocketClient.socket?.clearListeners();
    getsocketClient.socket?.disconnect();
  }

  void connect() {
    getsocketClient.socket?.connect();
  }

  void connectionErrorListener(Function(dynamic) callback) async {
    debugPrint("connect_error ");

    getsocketClient.socket!.on("connect_error", callback);
  }

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      getsocketClient.socket!.emit(
        "createRoom",
        {"roomName": nickName},
      );
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      getsocketClient.socket!.emit(
        "joinRoom",
        {
          "nickName": nickName,
          "roomId": roomId,
        },
      );
    }
  }

  void leaveRoom(String roomId) {
    getsocketClient.socket!.emit("leaveRoom", {
      "roomId": roomId,
    });
  }

  void tapGrid(int index, String roomId) {
    debugPrint("from socket method tapGrid");
    debugPrint("socket connection status ${getsocketClient.socket!.connected}");
    getsocketClient.socket!.emit("boardTap", {
      "index": index,
      "roomId": roomId,
    });
  }

  void winner(String roomId, String playerType) {
    getsocketClient.socket!.emit("winner", {
      "roomId": roomId,
      "playerType": playerType,
    });
  }

  void draw(String roomId) {
    getsocketClient.socket!.emit("matchDraw", {
      "roomId": roomId,
    });
  }

  void createRoomSuccessListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("createRoomSuccess", callback);
  }

  void newPlayerJoinedListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("newPlayerJoined", callback);
  }

  void joinRoomSuccessListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("joinRoomSuccess", callback);
  }

  void joinRoomFailureListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("joinRoomError", callback);
  }

  void tapListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("tapped", callback);
  }

  void leaveRoomListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("playerLeft", callback);
  }

  void addPointsListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("addPoints", callback);
  }

  void noPointsListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("noPoints", callback);
  }

  void winnerListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("playerWon", callback);
  }

  void defeatListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("playerDefeated", callback);
  }

  void matchDrawListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("matchDraw", callback);
  }

  void gameDrawListener(Function(dynamic) callback) async {
    getsocketClient.socket!.on("gameDraw", callback);
  }
}
