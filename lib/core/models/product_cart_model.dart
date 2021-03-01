class ProductCart{

  final String name;
  final String productId;
  final String cartId;
  final int quantity;

  ProductCart({
    this.name = '',
    this.productId, 
    this.cartId, 
    this.quantity
  });

  factory ProductCart.fromMap(Map<String, dynamic> map) => ProductCart(
    cartId: map['cart_id'],
    productId: map['product_id'],
    quantity: map['quantity']
  );

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
    name: json['name'],
    cartId: json['cart_id'],
    productId: json['product_id'],
    quantity: json['quantity']
  );

  ProductCart copyWith({
    String name,
    String productId,
    String cartId,
    int quantity
  }) => ProductCart(
    name:  name?? this.name,
    productId: productId?? this.productId, 
    cartId: cartId?? this.cartId, 
    quantity: quantity?? this.quantity
  );

  Map<String, dynamic> toMap() =>{
    'product_id': this.productId,
    'cart_id': this.cartId,
    'quantity': this.quantity
  };

  Map<String, dynamic> toJson() =>{
    'name': this.name,
    'product_id': this.productId,
    'cart_id': this.cartId,
    'quantity': this.quantity
  };
}