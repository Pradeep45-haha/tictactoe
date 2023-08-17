part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

class GameInitialEvent extends GameEvent{}



class PlayerTappedEvent extends GameEvent{
  final int index;
  PlayerTappedEvent({required this.index});
}


class PlayerGameDataFromServerEvent extends GameEvent{

}

class PlayerWantToLeaveEvent extends GameEvent{}

class PlayerLeaveSuccessEvent extends GameEvent{}