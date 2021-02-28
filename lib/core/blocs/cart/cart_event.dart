part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnInitCart extends CartEvent { }

class OnAddProductCart extends CartEvent { 
  final ProductCart productCart;
  OnAddProductCart(this.productCart);
}

class OnIncrementProductQuantity extends CartEvent {
  final int index;
  OnIncrementProductQuantity(this.index);
}

class OnDecrementProductQuantity extends CartEvent {
  final int index;
  OnDecrementProductQuantity(this.index);
}

class OnDeleteProduct extends CartEvent {
  final String productId;
  OnDeleteProduct(this.productId);
}

class OnCompleteCart extends CartEvent { }