import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/shared/widgets/searchbox_widget.dart';

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        _background(screenSize),
        _title(screenSize),
        _searchBox()
      ],
    );
  }

  Widget _background(Size screenSize){
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.22,
      margin: EdgeInsets.only(bottom:20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0,5),
            blurRadius: 5.0
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal[600],
            Colors.lightGreen[300],
          ]
        )
      ),
    );
  }

  Widget _title(Size screenSize){
    return Positioned(
      top: screenSize.height * 0.1,
      left: 0.0,
      right: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shopping Cart', style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold)),
            Icon(Icons.shopping_cart_outlined, size: 30.0, color: Colors.white)
          ],
        ),
      ),
    );
  }

  Widget _searchBox(){

    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: SearchBox()
    );
  }
}