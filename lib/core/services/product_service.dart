import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';

class ProductService {

  ProductService._privateConstructor();
  static final _instance = ProductService._privateConstructor();

  factory ProductService() => _instance;

  final CollectionReference _products = FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async{

    QuerySnapshot snapshot = await _products.get();
    if(snapshot.docs.isNotEmpty){
      List<Product> products = snapshot.docs.map((doc) => Product.fromMap({'id': doc.id, ...doc.data()})).toList();
      return products;
    }
    return [];
  }
  
}