import 'dart:convert';

class Player {
  final String nickName;
  final String socketId;
  final String matchWon;
  final String playerType;
  final String id;
  Player({
    required this.nickName,
    required this.socketId,
    required this.matchWon,
    required this.playerType,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickName': nickName,
      'socketId': socketId,
      'matchWon': matchWon,
      'playerType': playerType,
      'id': id,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickName: map['nickName'].toString(),
      socketId: map['socketId'].toString(),
      matchWon: map['matchWon'].toString(),
      playerType: map['playerType'].toString(),
      id: map['_id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);
}
