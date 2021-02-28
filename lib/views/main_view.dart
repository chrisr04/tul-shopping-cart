import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/views/home_view.dart';
import 'package:tul_shopping_cart/views/my_orders_view.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  int _selectedIndex = 0;
  final List<Widget> _widgets = [
    HomeView(),
    MyOrdersView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal[600],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_rounded),
            label: 'Mis pedidos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onChangeView,
      ),
    );
  }

  void _onChangeView(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}