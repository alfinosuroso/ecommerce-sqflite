part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductDetail> products;
  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductLoadedById extends ProductState {
  final ProductDetail product;
  const ProductLoadedById(this.product);

  @override
  List<Object> get props => [product];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductSuccess extends ProductState {
  final String message;
  const ProductSuccess(this.message);

  @override
  List<Object> get props => [message];
}
