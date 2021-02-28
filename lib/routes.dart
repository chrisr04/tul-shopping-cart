import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/views/cart_view.dart';
import 'package:tul_shopping_cart/views/home_view.dart';
import 'package:tul_shopping_cart/views/main_view.dart';
import 'package:tul_shopping_cart/views/my_orders_view.dart';
import 'package:tul_shopping_cart/views/order_view.dart';

Map<String, WidgetBuilder> getRoutes(RouteSettings settings){

  final Map<String, dynamic> params = settings.arguments;

  return {
    'main': (BuildContext context) => MainView(),
    'home': (BuildContext context) => HomeView(),
    'cart': (BuildContext context) => CartView(),
    'my_orders': (BuildContext context) => MyOrdersView(),
    'order': (BuildContext context) => OrderView(title: params['title'], index: params['index'])
  };
}

MaterialPageRoute<dynamic> generateRoutes(RouteSettings settings) {
  Map<String, WidgetBuilder> routes = getRoutes(settings);
  WidgetBuilder builder = routes[settings.name];
  return MaterialPageRoute(settings: settings, builder: (BuildContext context) => builder(context));
}