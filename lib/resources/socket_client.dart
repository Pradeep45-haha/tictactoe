import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;
  static SocketClient? _instance;

  SocketClient._() {
    socket = io.io(
      "http://192.168.0.7:3000",
      io.OptionBuilder()
          .setTransports(["websocket"])
          .enableAutoConnect()
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
  static SocketClient get instance {
    return _instance ??= SocketClient._();
  }
}
