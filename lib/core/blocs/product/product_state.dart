part of 'product_bloc.dart';

@immutable
class ProductState {

  final List<Product> products;
  final bool isLoaded;

  ProductState({
    List<Product> products,
  }): this.products = products?? [],
      this.isLoaded = (products !=null)? true : false;

  ProductState copyWith({
    List<Product> products
  }) => ProductState(
    products: products?? this.products
  );
}

