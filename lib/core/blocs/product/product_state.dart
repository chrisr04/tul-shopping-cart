part of 'product_bloc.dart';

@immutable
class ProductState {

  final Stream<QuerySnapshot> productsStream;
  final bool isLoaded;

  ProductState({
    Stream<QuerySnapshot> productsStream,
  }): this.productsStream = productsStream?? null,
      this.isLoaded = (productsStream != null)? true : false;

  ProductState copyWith({
    Stream<QuerySnapshot> productsStream
  }) => ProductState(
    productsStream: productsStream?? this.productsStream
  );
}

