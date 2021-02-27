import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: _input(),
    );
  }

  Widget _input(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0,5),
            blurRadius: 5.0
          )
        ]
      ),
      child: TextField(
        cursorColor: Colors.grey[400],
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15.0, left: 12.0),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          hintText: 'Buscar productos...',
          suffixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none
        ),
      ),
    );
  }
}