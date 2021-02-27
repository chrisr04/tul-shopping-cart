import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/core/services/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartService _cartService = CartService();

  CartBloc() : super(CartState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {

    if(event is OnCreateCart){
      yield* _onCreateCart();
    }else if(event is OnAddProductCart){
      yield* _onAddProductCart(event);
    }else if (event is OnUpdateProductQuantity){
      yield* _onUpdateProductQuantity(event);
    }else if(event is OnDeleteProduct){
      yield* _onDeleteProduct(event);
    }else if(event is OnCompleteCart){
      yield* _onCompleteCart(event);
    }
 
  }

 Stream<CartState> _onCreateCart() async* {
   try {
    Cart newCart = await _cartService.addCart();
    yield state.copyWith(cart: newCart);
   } catch (e) {
     throw e;
   }
 }

 Stream<CartState> _onAddProductCart(OnAddProductCart event) async* {

 }

 Stream<CartState> _onUpdateProductQuantity(OnUpdateProductQuantity event) async* {

 }
 
 Stream<CartState> _onDeleteProduct(OnDeleteProduct event) async* {

 }

 Stream<CartState> _onCompleteCart(OnCompleteCart event) async* {
  try {
    Cart newCart = await _cartService.completeCart(event.cart);
    yield state.copyWith(cart: newCart);
   } catch (e) {
     throw e;
   }
 }
  
}
