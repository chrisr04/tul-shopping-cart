import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tul_shopping_cart/core/models/cart_model.dart';

class CartService {

  CartService._privateConstructor();
  static final _instance = CartService._privateConstructor();

  factory CartService() => _instance;
  
  final CollectionReference _carts = FirebaseFirestore.instance.collection('carts');

  Future<Cart> initCart() async{

    QuerySnapshot snapshot = await _carts.where('status', isEqualTo: 'pending').limit(1).get();
    
    if(snapshot.docs.isNotEmpty){
      QueryDocumentSnapshot doc = snapshot.docs.first;
      return Cart.fromMap(doc.data());
    }else{

      DocumentReference doc = _carts.doc();
      await  doc.set({
        'id': doc.id,
        'status': 'pending'
      });
      return Cart(id: doc.id);
    }
  }

  Future<void> completeCart(Cart cart) async{
    DocumentReference doc = _carts.doc(cart.id);
    await  doc.set({
      'status': 'completed'
    }, SetOptions(merge: true));
  }

  Future<List<Cart>> getCompletedCarts() async{
    QuerySnapshot snapshot = await _carts.where('status', isEqualTo: 'completed').get();
    if(snapshot.docs.isNotEmpty){
      List<Cart> cartsCompleted = snapshot.docs.map((doc) => Cart.fromMap(doc.data())).toList();
      return cartsCompleted;
    }
    return [];
  }
  
}