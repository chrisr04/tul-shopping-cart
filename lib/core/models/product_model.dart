class Product {

  final String id;
  final String sku;
  final String name;
  final String description;

  Product({
    this.id,
    this.sku,
    this.name,
    this.description
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map['id'],
    sku: map['sku'],
    name: map['name'],
    description: map['description']
  );

  Product copyWith({
    String id,
    String sku,
    String name,
    String description
  }) => Product(
    id: id?? this.id,
    sku: sku?? this.sku,
    name: name?? this.name,
    description: description?? this.description
  );
  
}