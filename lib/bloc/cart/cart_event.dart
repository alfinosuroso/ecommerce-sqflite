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

class GetCart extends CartEvent {}

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
  final int cartId, userId;
  const DeleteCart(this.cartId, this.userId);

  @override
  List<Object> get props => [cartId, userId];
}

class DeleteCartByUserId extends CartEvent {
  final int userId;
  const DeleteCartByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}

class CheckoutCart extends CartEvent {
  final int userId;
  const CheckoutCart(this.userId);

  @override
  List<Object> get props => [userId];
}
