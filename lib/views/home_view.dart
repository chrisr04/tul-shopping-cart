import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/product/product_bloc.dart';
import 'package:tul_shopping_cart/shared/widgets/header_widget.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';
import 'package:tul_shopping_cart/shared/widgets/product_grid_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  ProductBloc _productBloc;
  CartBloc _cartBloc;


  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _productBloc.add(OnLoadProducts());
    _cartBloc.add(OnInitCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _init(),
    );
  }

  Widget _init(){
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if(state.isLoaded){
          return Stack(
            children: [
              ProductGrid(
                products: state.products
              ),
              Header(),
            ],
          );
        }else{
          return _loader();
        }
      },
    );
  }

  Widget _loader(){
    return Center(
      child: Loader(
        size: 35.0,
        primaryColor: Colors.teal[600],
        secondaryColor: Colors.white,
      ),
    );
  }
}