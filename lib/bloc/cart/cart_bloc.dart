import 'package:bloc/bloc.dart';
import 'package:ecommerce_sqflite/models/cart.dart';
import 'package:ecommerce_sqflite/models/cart_detail.dart';
import 'package:ecommerce_sqflite/services/dao/cart_dao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartDao cartDao;
  CartBloc(this.cartDao) : super(CartInitial()) {
    on<CartEvent>((event, emit) {});

    on<AddToCart>((event, emit) async {
      emit(CartLoading());
      try {
        bool success = await cartDao.addToCart(event.cart);
        if (success) {
          emit(const CartSuccess("Berhasil menambahkan produk ke keranjang"));
        } else {
          emit(const CartError("Gagal menambahkan produk ke keranjang"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(CartError(e.toString()));
      }
    });

    on<GetCartByUserId>((event, emit) async {
      emit(CartLoading());
      try {
        List<CartDetail> cart = await cartDao.getCartByUserId(event.userId);
        emit(CartLoaded(cart));
      } catch (e) {
        debugPrint(e.toString());
        emit(CartError(e.toString()));
      }
    });

    on<UpdateCart>((event, emit) async {
      emit(CartInitial());
      try {
        bool success = await cartDao.updateCart(event.cart);
        if (success) {
          add(GetCartByUserId(event.cart.userId));
          emit(const CartSuccess("Berhasil memperbarui produk di keranjang"));
        } else {
          emit(const CartError("Gagal memperbarui produk di keranjang"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(CartError(e.toString()));
      }
    });

    on<DeleteCart>((event, emit) async {
      emit(CartLoading());
      try {
        bool success = await cartDao.deleteCart(event.cartId);
        if (success) {
          emit(const CartSuccess("Berhasil menghapus produk di keranjang"));
        } else {
          emit(const CartError("Gagal menghapus produk di keranjang"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(CartError(e.toString()));
      }
    });

    on<DeleteCartByUserId>((event, emit) async {
      emit(CartLoading());
      try {
        bool success = await cartDao.deleteCartByUserId(event.userId);
        if (success) {
          emit(const CartSuccess("Berhasil menghapus produk di keranjang"));
        } else {
          emit(const CartError("Gagal menghapus produk di keranjang"));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
