part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class GetProducts extends ProductEvent {
  @override
  List<Object> get props => [];
}

class GetProductsByUserId extends ProductEvent {
  final int userId;
  const GetProductsByUserId(this.userId);
  @override
  List<Object> get props => [userId];
}

class GetProductById extends ProductEvent {
  final int productId;
  const GetProductById(this.productId);
  @override
  List<Object> get props => [productId];
}

class UpdateProduct extends ProductEvent {
  final Product product;
  const UpdateProduct(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final int productId;
  const DeleteProduct(this.productId);
  @override
  List<Object> get props => [productId];
}