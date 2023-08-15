part of 'create_room_bloc.dart';

@immutable
sealed class CreateRoomState {}

final class CreateRoomInitial extends CreateRoomState {}
final class CreateRoomSuccessState extends CreateRoomState {}


