
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCartsService {
  ProductCartsService._privateConstructor();
  static final _instance = ProductCartsService._privateConstructor();

  factory ProductCartsService() => _instance;

  CollectionReference _product_carts = FirebaseFirestore.instance.collection('product_carts');

}