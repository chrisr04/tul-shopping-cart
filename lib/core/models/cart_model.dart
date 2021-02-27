class Cart {

  final String id;
  final String status;

  Cart({
    this.id, 
    this.status = 'pending'
  });

  factory Cart.fromMap(Map<String, dynamic> map) => Cart(
    id: map['id'],
    status: map['status']
  );

  Cart copyWith({
    String id,
    String status,
  }) => Cart(
    id: id?? this.id,
    status:  status?? this.status 
  );
 
}