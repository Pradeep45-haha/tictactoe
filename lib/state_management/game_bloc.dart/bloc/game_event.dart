part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

class GameInitialEvent extends GameEvent {}

class PlayerTappedEvent extends GameEvent {
  final int index;
  PlayerTappedEvent({required this.index});
}

class PlayerGameDataFromServerEvent extends GameEvent {}

class PlayerWantToLeaveEvent extends GameEvent {}

class PlayerLeaveSuccessEvent extends GameEvent {}

class PlayerWonEvent extends GameEvent {}

class PlayerDefeatedEvent extends GameEvent {}

class PlayerDrawEvent extends GameEvent {}


class PlayerPointEvent extends GameEvent{}
class PlayerNoPointEvent extends GameEvent{}
class GameDrawEvent extends GameEvent{}