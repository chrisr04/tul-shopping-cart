part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnInitCart extends CartEvent { }

class OnAddProductCart extends CartEvent { 
  final ProductCart product;
  OnAddProductCart(this.product);
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
  final ProductCart productCart;
  OnDeleteProduct(this.productCart);
}

class OnCompleteCart extends CartEvent { }