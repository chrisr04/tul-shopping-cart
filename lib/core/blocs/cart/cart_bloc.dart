import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/services/cart_service.dart';
import 'package:tul_shopping_cart/core/services/product_carts_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartService _cartService = CartService();
  ProductCartsService _productCartsService = ProductCartsService();

  CartBloc() : super(CartState());

  bool isAdded(String productId){
    List<ProductCart> list = state.products.where((p) => p.productId == productId).toList();
    if(list.length == 1){
      return true;
    }
    return false;
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {

    if(event is OnCreateCart){
      yield* _onCreateCart();
    }else if(event is OnAddProductCart){
      yield* _onAddProductCart(event);
    }else if (event is OnIncrementProductQuantity){
      yield* _onIncrementProductQuantity(event);
    }else if (event is OnDecrementProductQuantity){
      yield* _onDecrementProductQuantity(event);
    }else if(event is OnDeleteProduct){
      yield* _onDeleteProduct(event);
    }else if(event is OnCompleteCart){
      yield* _onCompleteCart(event);
    }
 
  }

 Stream<CartState> _onCreateCart() async* {
   try {
    Cart newCart = await _cartService.createCart();
    // List<ProductCart> products = await _productCartsService.getProducts(newCart.id);
    yield state.copyWith(cart: newCart);
   } catch (e) {
     throw e;
   }
 }

 Stream<CartState> _onAddProductCart(OnAddProductCart event) async* {
   try {
    //  ProductCart newProductCart = await _productCartsService.addProductCart(event.product);
     yield state.copyWith(products: [...state.products, event.product]);
   } catch (e) {
     throw e;
   }
 }

 Stream<CartState> _onIncrementProductQuantity(OnIncrementProductQuantity event) async* {
   try {

      int quantity = event.productCart.quantity + 1;
      ProductCart newProductCart = event.productCart.copyWith(quantity: quantity);
      // await _productCartsService.updateQuantity(newProductCart);
      int index = state.products.indexWhere((p) => p.productId == newProductCart.productId);
      List<ProductCart> newProductList = state.products;
      newProductList[index] = newProductList[index].copyWith(quantity: newProductCart.quantity);
      yield state.copyWith(products: newProductList);
    
   } catch (e) {
     throw e;
   }
 }

  Stream<CartState> _onDecrementProductQuantity(OnDecrementProductQuantity event) async* {
   try {

    int quantity = event.productCart.quantity - 1;
    if(quantity > 0){
      ProductCart newProductCart = event.productCart.copyWith(quantity: quantity);
      // await _productCartsService.updateQuantity(newProductCart);
      int index = state.products.indexWhere((p) => p.productId == newProductCart.productId);
      List<ProductCart> newProductList = state.products;
      newProductList[index] = newProductCart;
      yield state.copyWith(products: newProductList);
    }
    
   } catch (e) {
     throw e;
   }
 }
 
 Stream<CartState> _onDeleteProduct(OnDeleteProduct event) async* {
   try {
    // await _productCartsService.deleteProductCart(event.productCart);
    List<ProductCart> newProducts = state.products.where((p) => p.productId != event.productCart.productId).toList();
    yield state.copyWith(products: newProducts);
   } catch (e) {
     throw e;
   }
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
