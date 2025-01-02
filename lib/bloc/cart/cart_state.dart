part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartDetail> cartDetailsList;
  const CartLoaded(this.cartDetailsList);

  @override
  List<Object> get props => [cartDetailsList];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

class CartSuccess extends CartState {
  final String message;
  const CartSuccess(this.message);

  @override
  List<Object> get props => [message];
}
