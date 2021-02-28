import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/views/cart_view.dart';
import 'package:tul_shopping_cart/views/home_view.dart';
import 'package:tul_shopping_cart/views/orders_view.dart';

Map<String, WidgetBuilder> getRoutes(RouteSettings settings){

  final Map<String, dynamic> params = settings.arguments;

  return {
    'home': (BuildContext context) => HomeView(),
    'cart': (BuildContext context) => CartView(),
    'orders': (BuildContext context) => OrdersView()
  };
}

MaterialPageRoute<dynamic> generateRoutes(RouteSettings settings) {
  Map<String, WidgetBuilder> routes = getRoutes(settings);
  WidgetBuilder builder = routes[settings.name];
  return MaterialPageRoute(settings: settings, builder: (BuildContext context) => builder(context));
}