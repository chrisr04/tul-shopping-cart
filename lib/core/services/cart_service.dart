import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';

class CartService {

  CartService._privateConstructor();
  static final _instance = CartService._privateConstructor();

  factory CartService() => _instance;
  
  final CollectionReference _carts = FirebaseFirestore.instance.collection('carts');

  Future<Cart> addCart() async{
    DocumentReference doc = _carts.doc();
    await  doc.set({
      'id': doc.id,
      'status': 'pending'
    });
    return Cart(id: doc.id);
  }

  Future<Cart> completeCart(Cart cart) async{
    DocumentReference doc = _carts.doc(cart.id);
    await  doc.set({
      'status': 'complete'
    });
    return cart.copyWith(status: 'complete');
  }
  
}