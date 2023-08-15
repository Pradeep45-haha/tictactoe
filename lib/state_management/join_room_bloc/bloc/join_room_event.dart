part of 'join_room_bloc.dart';

@immutable
sealed class JoinRoomEvent {}

class JoinRoomNameChangedEvent extends JoinRoomEvent {}

class JoinRoomIdChangedEvent extends JoinRoomEvent {}

class JoinRoomButtonPressed extends JoinRoomEvent{
  final String nickName;
  final String roomId;
  JoinRoomButtonPressed({required this.nickName, required this.roomId});
}

class JoinRoomSuccessDataFromServerEvent extends JoinRoomEvent{

}
class JoinRoomFailureDataFromServerEvent extends JoinRoomEvent{

}
