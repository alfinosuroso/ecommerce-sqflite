import 'package:bloc/bloc.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/user_dao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDao userDao;
  UserBloc(this.userDao) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<GetUserById>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userDao.getUser(event.id);
        emit(UserByIdLoaded(user));
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
    on<LoginUser>((event, emit) {});
    on<RegisterUser>((event, emit) async {
      emit(UserLoading());
      try {
        bool success = await userDao.insertUser(event.user);
        if (success) {
          emit(UserSuccess());
        } else {
          emit(const UserError('User with same name already exists'));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
  }
}
