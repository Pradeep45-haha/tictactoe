part of 'waiting_room_bloc.dart';

@immutable
sealed class WaitingRoomEvent {}
class WaitingRoomInitialEvent extends WaitingRoomEvent{
  
}

class NewPlayerJoinedEvent extends WaitingRoomEvent{

}