import 'package:flutter/material.dart';

class OrdersView extends StatefulWidget {
  OrdersView({Key key}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mis pedidos'),
        backgroundColor: Colors.teal[600],
      ),
      body: _body(),
    );
  }

  Widget _body(){
    return Container();
  }
}