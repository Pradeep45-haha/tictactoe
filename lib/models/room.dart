// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tictactoe/models/player.dart';

class Room {
  final String id;
  final Player turn;
  final String occupancy;
  final String maxRound;
  final String currentRound;
  final String isJoin;
  final String turnIndex;
  final List<Player> players;
  final String version;

  Room({
    required this.turn,
    required this.id,
    required this.occupancy,
    required this.maxRound,
    required this.currentRound,
    required this.isJoin,
    required this.players,
    required this.version,
    required this.turnIndex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      "turn": turn,
      'occupancy': occupancy,
      'maxRound': maxRound,
      'currentRound': currentRound,
      'isJoin': isJoin,
      'turnIndex': turnIndex,
      'players': players
          .map(
            (x) => x.toMap(),
          )
          .toList(),
      'version': version,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['_id'].toString(),
      turn: Player.fromMap(map["turn"]),
      occupancy: map['occupancy'].toString(),
      maxRound: map['maxRound'].toString(),
      currentRound: map['currentRound'].toString(),
      isJoin: map['isJoin'].toString(),
      turnIndex: map['turnIndex'].toString(),
      players: (map["players"] as List<dynamic>)
          .map(
            (e) => Player.fromMap(e),
          )
          .toList(),
      version: map['__v'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(id: $id, occupancy: $occupancy, maxRound: $maxRound, currentRound: $currentRound, isJoin: $isJoin, turnIndex: $turnIndex, players: $players, version: $version,"turn": $turn)';
  }
}
