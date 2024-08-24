import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._(String token) {
    socket = io.io(
      "http://127.0.0.1:3000",
      io.OptionBuilder()
          .setTransports(["websocket"])
          .enableAutoConnect()
          .setAuth({"authorisation": token})
          .build(),
    );

    socket!.onConnect((data) {
      debugPrint("socket connected");
    });
    socket!.onDisconnect((data) {
      debugPrint("socket disconnected");
    });

    socket!.onError((data) {
      debugPrint("socket on error $data");
    });
  }
  static SocketClient  getInstance(String token) {
    return _instance ??= SocketClient._(token);
  }
}
