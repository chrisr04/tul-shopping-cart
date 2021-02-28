
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';

class ProductCartsService {
  ProductCartsService._privateConstructor();
  static final _instance = ProductCartsService._privateConstructor();

  factory ProductCartsService() => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _productCarts = FirebaseFirestore.instance.collection('product_carts');

  Future<void> addProductCart(List<ProductCart> productsCart) async{
    WriteBatch batch = _firestore.batch();
    for (ProductCart product in productsCart) {
      DocumentReference doc = _productCarts.doc();
      batch.set(doc, product.toMap());
    }
    return batch.commit();
  }

}