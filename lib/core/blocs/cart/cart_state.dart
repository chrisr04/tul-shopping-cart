part of 'cart_bloc.dart';

@immutable
class CartState {

  final bool exist;
  final bool isCompleted;
  final bool isLoading;
  final Cart cart;
  final List<ProductCart> products;

  CartState({
    Cart cart,
    List<ProductCart> products,
    this.isCompleted = false,
    this.isLoading = false
  }): this.cart = cart?? null,
      this.products = products?? [],
      this.exist = (cart != null)? true:false;

  factory CartState.complete() => CartState(
    isCompleted: true
  );

  CartState copyWith({
    Cart cart,
    List<ProductCart> products,
    bool isLoading
  }) => CartState(
    cart: cart?? this.cart,
    products: products?? this.products,
    isLoading: isLoading?? this.isLoading
  );

}

