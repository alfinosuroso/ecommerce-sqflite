part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

class UserLoading extends UserState {
  List<Object> get props => [];
}

class UserByIdLoaded extends UserState {
  final User user;

  const UserByIdLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
