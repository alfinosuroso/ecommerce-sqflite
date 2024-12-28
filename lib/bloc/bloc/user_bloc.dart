import 'package:bloc/bloc.dart';
import 'package:ecommerce_sqflite/models/user.dart';
import 'package:ecommerce_sqflite/services/dao/user_dao.dart';
import 'package:ecommerce_sqflite/services/session/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserDao userDao;
  final AuthService authService;
  UserBloc(this.userDao, this.authService) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<GetUserById>((event, emit) async {
      try {
        final user = await userDao.getUser(event.id);
        emit(UserByIdLoaded(user));
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
    on<LoginUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user =
            await userDao.verifyUserCredential(event.email, event.password);
        debugPrint(user.toString());
        if (user.id != null) {
          debugPrint("masuk if");
          await authService.storeUser(user);
          emit(const UserSuccess("Login berhasil"));
          emit(UserByIdLoaded(user));
        } else {
          debugPrint("masuk else");

          emit(const UserError("Email atau password salah"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
    on<RegisterUser>((event, emit) async {
      emit(UserLoading());
      try {
        bool success = await userDao.insertUser(event.user);
        if (success) {
          emit(const UserSuccess("Registrasi berhasil, silahkan login"));
        } else {
          emit(const UserError("User dengan email yang sama sudah terdaftar"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
    on<CheckUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await authService.getUser();
        if (user != null) {
          emit(UserByIdLoaded(user));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserError(e.toString()));
      }
    });
  }
}
