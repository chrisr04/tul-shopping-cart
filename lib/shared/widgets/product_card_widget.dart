import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final void Function() onAddCart;
  final void Function() onshowDetails;

  const ProductCard({
    Key key, 
    @required this.product, 
    @required this.onAddCart, 
    @required this.onshowDetails
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          children: [
            Text(product.name, textAlign: TextAlign.start,  maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.teal[600], fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 5.0),
            Text(product.description, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 4, style: TextStyle(color: Colors.grey[600])),
            _addCartBtn(),
            _showDetailsBtn()
          ],
        )
      ),
    );
  }

  Widget _addCartBtn(){
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.teal[600],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_shopping_cart_rounded, color: Colors.white),
            SizedBox(width: 5.0),
            Text('Agregar', style: TextStyle(color: Colors.white),)
          ],
        ),
        onPressed: onAddCart
      ),
    );
  }

  Widget _showDetailsBtn(){
    return Container(
      width: double.infinity,
      child: OutlineButton(
        shape: StadiumBorder(),
        color: Colors.teal[600],
        borderSide: BorderSide(
          color: Colors.teal[600],
          width: 2.0,
        ),
        highlightedBorderColor: Colors.teal[600],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list, color: Colors.teal[600]),
            SizedBox(width: 5.0),
            Text('Detalles', style: TextStyle(color: Colors.teal[600]),)
          ],
        ),
        onPressed: onshowDetails
      ),
    );
  }
}