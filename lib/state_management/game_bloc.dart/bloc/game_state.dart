part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

class NewPlayerJoinedState extends GameState{}

class PlayerGameDataFromServerState extends GameState{}