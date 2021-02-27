part of 'cart_bloc.dart';

@immutable
class CartState {

  final bool exist;
  final Cart cart;
  final List<ProductCart> products;

  CartState({
    Cart cart,
    List<ProductCart> products,
  }): this.cart = cart?? null,
      this.products = products?? [],
      this.exist = (cart != null)? true:false;

  CartState copyWith({
    Cart cart,
    List<ProductCart> products
  }) => CartState(
    cart: cart?? this.cart,
    products: products?? this.products
  );

}

