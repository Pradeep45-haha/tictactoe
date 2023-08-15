part of 'join_room_bloc.dart';

@immutable
sealed class JoinRoomState {}

final class JoinRoomInitial extends JoinRoomState {}

final class JoinRoomSuccessState extends JoinRoomState {}
final class JoinRoomFailureState extends JoinRoomState {}


