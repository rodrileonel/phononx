part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UsersEvent {
  final String user;
  const GetUserEvent(this.user);
}