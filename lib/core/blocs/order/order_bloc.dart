import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';
import 'package:tul_shopping_cart/core/models/order_model.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/core/services/cart_service.dart';
import 'package:tul_shopping_cart/core/services/product_carts_service.dart';
import 'package:tul_shopping_cart/core/services/product_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {

  CartService _cartService = CartService();
  ProductCartsService _productCartsService = ProductCartsService();
  ProductService _productService = ProductService();

  OrderBloc() : super(OrderState());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if(event is OnInitOrders){
      yield* _onInitOrders();
    }else if(event is OnLoadProductsOrder){
      yield* _onLoadProducts(event);
    }
  }

  Stream<OrderState> _onInitOrders() async*{
    try {
     List<Cart> carts = await _cartService.getCompletedCarts();
     List<Order> myOrders = carts.map((cart) => Order(cartId: cart.id)).toList();
     yield state.copyWith(orders: myOrders);
    } catch (e) {
      throw e;
    }
  }

  Stream<OrderState> _onLoadProducts(OnLoadProductsOrder event) async*{
    try {
      List<Order> orders = state.orders;
      List<ProductCart> productCarts = await _productCartsService.getProductsCart(orders[event.index].cartId);
      List<String> ids = productCarts.map((p) => p.productId).toList();
      List<Product> products = await _productService.getProductsByIds(ids);
      List<Map<String, dynamic>> records = [];
      for (int i = 0; i < products.length; i++) {
        final productCart = productCarts.firstWhere((pc) => pc.productId == products[i].id);
        records.add({
          'product': products[i],
          'quantity': productCart.quantity
        });
      }
      orders[event.index] = orders[event.index].copyWith(records: records);
      yield state.copyWith(orders: orders);
    } catch (e) {
      throw e;
    }
  }
}
