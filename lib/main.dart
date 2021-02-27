import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/order/order_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/product/product_bloc.dart';
import 'package:tul_shopping_cart/routes.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ProductBloc()),
        BlocProvider(create: (BuildContext context) => CartBloc()),
        BlocProvider(create: (BuildContext context) => OrderBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Carts',
        initialRoute: 'home',
        onGenerateRoute: generateRoutes
      ),
    );
  }
}