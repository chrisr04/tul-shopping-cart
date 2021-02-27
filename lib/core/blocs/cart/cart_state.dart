part of 'cart_bloc.dart';

@immutable
class CartState {

  final bool exist;
  final Cart cart;
  final List<Map<String, dynamic>> products;

  CartState({
    Cart cart,
    List<Map<String, dynamic>> products,
  }): this.cart = cart?? null,
      this.products = products?? [],
      this.exist = (cart != null)? true:false;

  CartState copyWith({
    Cart cart,
    List<Map<String, dynamic>> products
  }) => CartState(
    cart: cart?? this.cart,
    products: products?? this.products
  );

}

