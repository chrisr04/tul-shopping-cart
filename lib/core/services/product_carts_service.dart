
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';

class ProductCartsService {
  ProductCartsService._privateConstructor();
  static final _instance = ProductCartsService._privateConstructor();

  factory ProductCartsService() => _instance;

  CollectionReference _productCarts = FirebaseFirestore.instance.collection('product_carts');

  Future<ProductCart> addProductCart(ProductCart productCart) async{
    DocumentReference doc = _productCarts.doc();
    await doc.set(productCart.toMap());
    return productCart.copyWith(id: doc.id);
  }

  Future<List<ProductCart>> getProducts(String cartId) async{
    QuerySnapshot snapshot = await _productCarts.where('cart_id', isEqualTo: cartId).get();
    if(snapshot.docs.isNotEmpty){
      List<ProductCart> products = snapshot.docs.map((doc) => ProductCart.fromMap({'id': doc.id, ...doc.data()})).toList();
      return products;
    }
    return [];
  }

  Future<void> updateQuantity(ProductCart productCart) async{
    DocumentReference doc = _productCarts.doc(productCart.id);
    return doc.set({
      'quantity': productCart.quantity
    }, SetOptions(merge: true));
  }

  Future<void> deleteProductCart(ProductCart productCart) async{
     DocumentReference doc = _productCarts.doc(productCart.id);
     return doc.delete();
  }

}