import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/core/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductService _productService = ProductService();

  Product getProduct(String id){
    return state.products.firstWhere((p) => p.id == id, orElse: () => null);
  }

  ProductBloc() : super(ProductState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if(event is OnLoadProducts){
      yield* _onLoadProducts();
    }
  }

  Stream<ProductState> _onLoadProducts() async*{
    try {
      List<Product> products = await _productService.getProducts();
      yield state.copyWith(products: products);
    } catch (e) {
      throw e;
    }
  }

  

}
