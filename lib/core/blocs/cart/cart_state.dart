part of 'cart_bloc.dart';

@immutable
class CartState {

  final Cart cart;
  final List<ProductCart> productsCart;
  final bool exist;
  final bool isCompleted;
  final bool isLoading;

  CartState({
    Cart cart,
    List<ProductCart> productsCart,
    this.isCompleted = false,
    this.isLoading = false
  }): this.cart = cart?? null,
      this.productsCart = productsCart?? [],
      this.exist = (cart != null)? true:false;

  factory CartState.complete() => CartState(
    isCompleted: true
  );

  CartState copyWith({
    Cart cart,
    List<ProductCart> productsCart,
    bool isLoading
  }) => CartState(
    cart: cart?? this.cart,
    productsCart: productsCart?? this.productsCart,
    isLoading: isLoading?? this.isLoading
  );

}

