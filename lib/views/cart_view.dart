import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/product/product_bloc.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';

class CartView extends StatefulWidget {
  CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  ProductBloc _productBloc;
  CartBloc _cartBloc;

  @override
  void initState() {
    _productBloc = BlocProvider.of<ProductBloc>(context);
    _cartBloc = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Carrito de compras', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.teal[600]),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: _init(),

    );
  }

  Widget _init(){
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return _body(state.products);
      },
    );
  }

  Widget _body(List<ProductCart> productCarts){

    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text('Productos', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
          ),
          _table(productCarts),
          _orderBtn()
        ],
      ),
    );
  }

  Widget _table(List<ProductCart> productCarts){
    return Expanded(
      child: SingleChildScrollView(
        child: Table( 
          columnWidths: {
            0: FixedColumnWidth(250),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: FlexColumnWidth(),
          children: _productRows(productCarts),  
          
        ),
      ),
    );
  }

  List<TableRow> _productRows(List<ProductCart> productCarts){

    return productCarts.map((productCart) { 
        return _productItem(productCart);
      }
    ).toList();

  }

  TableRow _productItem(ProductCart productCart){

    Product product = _productBloc.getProduct(productCart.productId);

    return TableRow(
      
      children: [  
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Text(product.name, style: TextStyle(fontSize: 17.0))
          )
        ),  
        Container(
          margin: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100.0,
                height: 30.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal[600], width: 2.0),
                  borderRadius: BorderRadius.circular(35.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Icon(Icons.add_rounded, color: Colors.teal[600]),
                      onTap: (){
                        _cartBloc.add(OnIncrementProductQuantity(productCart));
                      }
                    ),
                    Text('${productCart.quantity}'),
                    InkWell(
                      child: Icon(Icons.remove_rounded, color: Colors.teal[600]),
                      onTap: (){
                        _cartBloc.add(OnDecrementProductQuantity(productCart));
                      }
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: 100.0,
                height: 30.0,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.red[700],
                  child: Text('Quitar', style: TextStyle(color: Colors.white)),
                  onPressed: (){
                    _cartBloc.add(OnDeleteProduct(productCart));
                  }
                ),
              )
            ],
          ),
        ),
      ]
    );
  }

  Widget _orderBtn(){
    return Center(
      child: Container(
        width: 190.0,
        height: 40.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: RaisedButton(
          color: Colors.teal[600],
          shape: StadiumBorder(),
          child: Text('Ordenar pedido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: (){

          }
        )
      ),
    );
  }
}