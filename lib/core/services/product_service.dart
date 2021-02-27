import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {

  ProductService._privateConstructor();
  static final _instance = ProductService._privateConstructor();

  factory ProductService() => _instance;

  final CollectionReference _products = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getProducts(){
    return _products.snapshots();
  }
  
}