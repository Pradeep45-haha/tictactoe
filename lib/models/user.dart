import 'dart:convert';

class User {
  final String username;
  final String email;
  final String rank;
  final int matchWon;
  final bool isOnline;
  final bool isWaiting;
  final bool isPlaying;

  User(
      {required this.username,
      required this.email,
      required this.rank,
      required this.matchWon,
      required this.isOnline,
      required this.isWaiting,
      required this.isPlaying});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "username": username,
      "email": email,
      "rank": rank,
      "matchWon": matchWon,
      "isOnline": isOnline,
      "isWaiting": isWaiting,
      "isPlaying": isPlaying,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        email: map["email"],
        username: map["username"],
        isOnline: map["isOnline"],
        isPlaying: map["isPlaying"],
        isWaiting: map["isWaiting"],
        matchWon: map["matchWon"],
        rank: map["rank"]);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return "email: $email, username: $username, isOnline: $isOnline, isPlaying: $isPlaying, isWaiting: $isWaiting, matchWon: $matchWon, rank: $rank";
  }
}
