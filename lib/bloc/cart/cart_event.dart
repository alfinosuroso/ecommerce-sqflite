part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Cart cart;
  const AddToCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class GetCartByUserId extends CartEvent {
  final int userId;
  const GetCartByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateCart extends CartEvent {
  final Cart cart;
  const UpdateCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class DeleteCart extends CartEvent {
  final int cartId;
  const DeleteCart(this.cartId);

  @override
  List<Object> get props => [cartId];
}

class DeleteCartByUserId extends CartEvent {
  final int userId;
  const DeleteCartByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}
