part of 'create_room_bloc.dart';

@immutable
sealed class CreateRoomEvent {}

class CreateRoomNameChangedEvent extends CreateRoomEvent {}

class CreateRoomWithNameEvent extends CreateRoomEvent {
  final String roomName;
  CreateRoomWithNameEvent({required this.roomName});
}


final class CreateRoomSuccessEvent extends CreateRoomEvent{}