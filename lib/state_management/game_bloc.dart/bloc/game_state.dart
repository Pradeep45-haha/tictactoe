part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

class NewPlayerJoinedState extends GameState {}

class PlayerGameDataFromServerState extends GameState {}

class PlayerLeftState extends GameState {}

class PlayerWonState extends GameState {}

class PlayerDefeatedState extends GameState {}

class PlayerDrawState extends GameState {}


class PlayerPointState extends GameState{}
class PlayerNoPointState extends GameState{}
class GameDrawState extends GameState{}