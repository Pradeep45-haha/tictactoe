part of 'waiting_room_bloc.dart';

@immutable
sealed class WaitingRoomState {}

final class WaitingRoomInitial extends WaitingRoomState {}

final class NewPlayerJoinedState extends WaitingRoomState{}
