part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserById extends UserEvent {
  final int id;
  const GetUserById(this.id);

  @override
  List<Object> get props => [id];
}

class LoginUser extends UserEvent {
  final String email, password;
  const LoginUser(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterUser extends UserEvent {
  final User user;
  const RegisterUser(this.user);

  @override
  List<Object> get props => [user];
}

class CheckUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdateUser extends UserEvent {
  final User user;
  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends UserEvent {
  final int id;
  const DeleteUser(this.id);

  @override
  List<Object> get props => [id];
}
