import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/product/product_bloc.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/shared/widgets/header_widget.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';
import 'package:tul_shopping_cart/shared/widgets/product_card_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  ProductBloc _productBloc;
  CartBloc _cartBloc;
  Size _screenSize;

  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _productBloc.add(OnLoadProducts());
    _cartBloc.add(OnCreateCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _screenSize = MediaQuery.of(context).size;

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
              _productGrid(state.products),
              Header(),
            ],
          );
        }else{
          return _loader();
        }
      },
    );
  }

  Widget _productGrid(List<Product> products){
    return Container(
      margin: EdgeInsets.only(top: _screenSize.height * 0.13),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0
        ),
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0, bottom: 80.0),
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index){

          return ProductCard(product: products[index]);
        },
      ),
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