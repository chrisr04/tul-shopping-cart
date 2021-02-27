class ProductCart{

  final String id;
  final String productId;
  final String cartId;
  final int quantity;

  ProductCart({
    this.id,
    this.productId, 
    this.cartId, 
    this.quantity
  });

  factory ProductCart.fromMap(Map<String, dynamic> map) => ProductCart(
    id: map['id'],
    cartId: map['cart_id'],
    productId: map['product_id'],
    quantity: map['quantity']
  );

  ProductCart copyWith({
    String id,
    String productId,
    String cartId,
    int quantity
  }) => ProductCart(
    id: id?? this.id,
    productId: productId?? this.productId, 
    cartId: cartId?? this.cartId, 
    quantity: quantity?? this.quantity
  );

  Map<String, dynamic> toMap() =>{
    'product_id': this.productId,
    'cart_id': this.cartId,
    'quantity': this.quantity
  };
}