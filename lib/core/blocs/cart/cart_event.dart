part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnCreateCart extends CartEvent { }

class OnAddProductCart extends CartEvent { 
  final Product product;
  OnAddProductCart(this.product);
}

class OnUpdateProductQuantity extends CartEvent {
  final int quantity;
  OnUpdateProductQuantity(this.quantity);
}

class OnDeleteProduct extends CartEvent {
  final String id;
  OnDeleteProduct(this.id);
}
class OnCompleteCart extends CartEvent { 
  final Cart cart;
  OnCompleteCart(this.cart);
}
