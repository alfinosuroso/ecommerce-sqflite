import 'package:bloc/bloc.dart';
import 'package:ecommerce_sqflite/models/product.dart';
import 'package:ecommerce_sqflite/models/product_detail.dart';
import 'package:ecommerce_sqflite/services/dao/product_dao.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDao productDao;
  ProductBloc(this.productDao) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {});

    on<GetProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await ProductDao().getAllProductDetails();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<GetProductsByUserId>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await ProductDao().getProductsByUserId(event.userId);
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        bool success = await ProductDao().insertProduct(event.product);
        if (success) {
          emit(const ProductSuccess("Product berhasil ditambahkan"));
        } else {
          emit(const ProductError("Product gagal ditambahkan"));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(ProductError(e.toString()));
      }
    });
  }
}
