part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

class InitialState extends UsersState {}

class LoadingState extends UsersState {}

class SuccessfulState extends UsersState {
  final List<User> users;
  const SuccessfulState(this.users);
}

class ErrorState extends UsersState {
  final String message;

  const ErrorState(this.message);
}
