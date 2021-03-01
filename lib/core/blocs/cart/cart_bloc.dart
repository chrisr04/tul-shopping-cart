import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/core/services/cart_service.dart';
import 'package:tul_shopping_cart/core/services/product_carts_service.dart';
import 'package:tul_shopping_cart/core/services/local_storage_service.dart';
import 'package:tul_shopping_cart/core/services/product_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartService _cartService = CartService();
  ProductService _productService = ProductService();
  ProductCartsService _productCartsService = ProductCartsService();
  LocalStorageService _localStorageService = LocalStorageService();

  CartBloc() : super(CartState());

  bool isAdded(String productId){
    List<ProductCart> list = state.productsCart.where((p) => p.productId == productId).toList();
    if(list.length == 1){
      return true;
    }
    return false;
  }

  Future<List<Product>> getProducts() async{
    List<String> ids = state.productsCart.map((pc) => pc.productId).toList();
    if(ids.isNotEmpty){
      List<Product> products = await _productService.getProductsByIds(ids);
      return products;
    }
    return [];
  }

  Future<void> _saveLocalData(List<ProductCart> products) async{
    List<Map<String, dynamic>> localData = products.map((p) => p.toMap()).toList();
    await _localStorageService.save('tul_shopping_cart', localData);
  }

  Future<List<ProductCart>> _readLocalData() async{
    final List<dynamic> localData = await _localStorageService.read('tul_shopping_cart');
    if(localData != null){
      List<ProductCart> products = localData.cast<Map<String, dynamic>>().map((p) => ProductCart.fromMap(p)).toList();
      return products;
    }
    return null;
  }

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {

    if(event is OnInitCart){
      yield* _onInitCart();
    }else if(event is OnAddProductCart){
      yield* _onAddProductCart(event);
    }else if (event is OnIncrementProductQuantity){
      yield* _onIncrementProductQuantity(event);
    }else if (event is OnDecrementProductQuantity){
      yield* _onDecrementProductQuantity(event);
    }else if(event is OnDeleteProduct){
      yield* _onDeleteProduct(event);
    }else if(event is OnCompleteCart){
      yield* _onCompleteCart();
    }
 
  }

  Stream<CartState> _onInitCart() async* {
    try {
      Cart newCart = await _cartService.initCart();
      List<ProductCart> productsCart = await _readLocalData();
      yield state.copyWith(cart: newCart, productsCart: productsCart);
    } catch (e) {
      throw e;
    }
  }

  Stream<CartState> _onAddProductCart(OnAddProductCart event) async* {
    List<ProductCart> products = [...state.productsCart, event.productCart];
    await _saveLocalData(products);
    yield state.copyWith(productsCart: products);
  }

  Stream<CartState> _onIncrementProductQuantity(OnIncrementProductQuantity event) async* {
    ProductCart product = state.productsCart[event.index];
    product = product.copyWith(quantity: product.quantity + 1);
    List<ProductCart> newProductList = state.productsCart;
    newProductList[event.index] = product;
    await _saveLocalData(newProductList);
    yield state.copyWith(productsCart: newProductList);
  }

  Stream<CartState> _onDecrementProductQuantity(OnDecrementProductQuantity event) async* {
    ProductCart product = state.productsCart[event.index];
    product = product.copyWith(quantity: product.quantity - 1);
    if(product.quantity > 0){
      List<ProductCart> newProductList = state.productsCart;
      newProductList[event.index] = product;
      await _saveLocalData(newProductList);
      yield state.copyWith(productsCart: newProductList);
    }
  }
 
  Stream<CartState> _onDeleteProduct(OnDeleteProduct event) async* {
    List<ProductCart> newProductList = state.productsCart.where((pc) => pc.productId != event.productId).toList();
    await _saveLocalData(newProductList);
    yield state.copyWith(productsCart: newProductList);
  }

  Stream<CartState> _onCompleteCart() async* {
    yield state.copyWith(isLoading: true);
    try {
      await _cartService.completeCart(state.cart);
      await _productCartsService.addProductsCart(state.productsCart);
      await _localStorageService.remove('tul_shopping_cart');
      yield CartState.complete();
      add(OnInitCart());
    } catch (e) {
      throw e;
    }
  }
  
}