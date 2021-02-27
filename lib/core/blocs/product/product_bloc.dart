import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show QuerySnapshot;
import 'package:meta/meta.dart';
import 'package:tul_shopping_cart/core/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  ProductService _productService = ProductService();

  ProductBloc() : super(ProductState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if(event is OnLoadProducts){
      yield* _onLoadProducts();
    }
  }

  Stream<ProductState> _onLoadProducts() async*{
    yield state.copyWith(
      productsStream: _productService.getProducts()
    );
  }

  

}
