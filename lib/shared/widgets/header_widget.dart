import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        _background(screenSize),
        _title(screenSize)
      ],
    );
  }

  Widget _background(Size screenSize){
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.18,
      margin: EdgeInsets.only(bottom:20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0,2),
            blurRadius: 5.0
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal[600],
            Colors.lightGreen[300]
          ]
        )
      ),
    );
  }

  Widget _title(Size screenSize){
    return Positioned(
      top: screenSize.height * 0.09,
      left: 0.0,
      right: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shopping Cart', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
            _iconCartBtn()
          ],
        ),
      ),
    );
  }

  Widget _iconCartBtn(){
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int length = state.productsCart.length;
        return GestureDetector(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 30.0, color: Colors.white),
              Positioned(
                top: -10.0,
                right: -10.0,
                child: (length > 0)? Container(
                  width: 23.0,
                  height: 23.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: Center(child: Text('$length', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                ) : Container()
              ) 
            ],
          ),
          onTap: (){
            Navigator.of(context).pushNamed('cart');
          },
        );
      },
    );
  }
}