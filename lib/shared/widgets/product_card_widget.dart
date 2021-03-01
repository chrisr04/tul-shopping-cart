import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/shared/helpers/alert_helper.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    Key key, 
    @required this.product
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
            Text(product.description, textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(color: Colors.grey[600])),
            Expanded(child: SizedBox(height: 5.0)),
            _addCartBtn(context),
            _showDetailsBtn(context)
          ],
        )
      ),
    );
  }

  Widget _addCartBtn(BuildContext context){

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {

        if(state.exist){

          CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);

          bool isAdded = _cartBloc.isAdded(product.id);

          return (!isAdded)? Container(
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
              onPressed:  (){

                ProductCart productCart =  ProductCart(
                  productId: product.id,
                  cartId: state.cart.id,
                  quantity: 1
                );
                
                _cartBloc.add(OnAddProductCart(productCart));
              }
            )
          ) : Container(
            width: double.infinity,
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Colors.red[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_circle_outline_rounded, color: Colors.white),
                  SizedBox(width: 5.0),
                  Text('Quitar', style: TextStyle(color: Colors.white),)
                ],
              ),
              onPressed:  (){
                _cartBloc.add(OnDeleteProduct(product.id));
              }
            )
          );
        }else{
          return Container();
        }

      },
    );
  }

  Widget _showDetailsBtn(BuildContext context){
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
        onPressed: (){
          showProductDetailAlert(context, product.description);
        }
      ),
    );
  }
}