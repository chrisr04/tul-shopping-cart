part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnCreateCart extends CartEvent { }

class OnAddProductCart extends CartEvent { 
  final ProductCart product;
  OnAddProductCart(this.product);
}

class OnIncrementProductQuantity extends CartEvent {
  final ProductCart productCart;
  OnIncrementProductQuantity(this.productCart);
}

class OnDecrementProductQuantity extends CartEvent {
  final ProductCart productCart;
  OnDecrementProductQuantity(this.productCart);
}

class OnDeleteProduct extends CartEvent {
  final ProductCart productCart;
  OnDeleteProduct(this.productCart);
}

class OnCompleteCart extends CartEvent { 
  final Cart cart;
  OnCompleteCart(this.cart);
}
