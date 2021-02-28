class Order {

  final String cartId;
  final List<Map<String, dynamic>> records;
  final bool isProductsLoaded;

  Order({
    this.cartId,
    List<Map<String, dynamic>> records
  }):this.records =  records?? [],
     this.isProductsLoaded = (records != null)? true : false;

  Order copyWith({
    String cartId,
    List<Map<String, dynamic>> records
  }) => Order(
    cartId: cartId?? this.cartId,
    records: records?? this.records
  );
  
}