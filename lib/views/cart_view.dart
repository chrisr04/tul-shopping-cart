import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/cart/cart_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/product/product_bloc.dart';
import 'package:tul_shopping_cart/core/models/product_cart_model.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/shared/helpers/alert_helper.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';

class CartView extends StatefulWidget {
  CartView({Key key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  CartBloc _cartBloc;
  ProductBloc _productBloc;

  @override
  void initState() {
    _cartBloc = BlocProvider.of<CartBloc>(context);
    _productBloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Carrito de compras', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[600]
      ),
      body: _init(),

    );
  }

  Widget _init(){

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {

        if(state.isLoading){
          showOrderLoadingAlert(context);
        }

        if(state.isCompleted){
          Navigator.of(context).pop();
          showOrderSuccessAlert(context);
        }
        
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if(state.productsCart.isNotEmpty){
            return _body(state.productsCart);
          }else{
            return _cartEmpty();
          }
        },
      ),
    );

  }

  Widget _body(List<ProductCart> productsCart){

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _title(),
          _table(productsCart),
          _orderBtn()
        ],
      ),
    );
  }

  Widget _title(){
    return Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Text('Productos', style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.bold))
    ); 
  }

  Widget _table(List<ProductCart> productsCart){

    List<String> productIds = productsCart.map((pc) => pc.productId).toList();

    return FutureBuilder(
      future: _productBloc.getProducts(productIds),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

        if(snapshot.hasData){

          List<Product> products = snapshot.data;
          
          return Expanded(
            child: SingleChildScrollView(
              child: Table( 
                columnWidths: {
                  0: FixedColumnWidth(250),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                defaultColumnWidth: FlexColumnWidth(),
                children: _productRows(products, productsCart)
              ),
            ),
          );

        }else{
          return _loader();
        }
      },
    );


  }

  List<TableRow> _productRows(List<Product> products, List<ProductCart> productsCart){
    List<TableRow> rows = [];
    for (int i = 0; i < productsCart.length; i++) {
      rows.add(_productItem(i, products[i], productsCart[i]));
    }
    return rows;
  }

  TableRow _productItem(int index, Product product, ProductCart productCart){

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
                        _cartBloc.add(OnIncrementProductQuantity(index));
                      }
                    ),
                    Text('${productCart.quantity}'),
                    InkWell(
                      child: Icon(Icons.remove_rounded, color: Colors.teal[600]),
                      onTap: (){
                        _cartBloc.add(OnDecrementProductQuantity(index));
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
                    _cartBloc.add(OnDeleteProduct(productCart.productId));
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
        width: 250.0,
        height: 40.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: RaisedButton(
          color: Colors.teal[600],
          shape: StadiumBorder(),
          child: Text('Ordenar pedido', style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold)),
          onPressed: (){
            _cartBloc.add(OnCompleteCart());
          }
        )
      ),
    );
  }

  Widget _cartEmpty(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.remove_shopping_cart_outlined, size: 70.0, color: Colors.teal[600]),
          SizedBox(height: 5.0),
          Text('No hay productos en el carrito', style: TextStyle(color: Colors.grey[600], fontSize: 20.0, fontWeight: FontWeight.bold))
        ],
      )
    );
  }

  Widget _loader(){
    return Expanded(
      child: Center(
        child: Loader(
          size: 35.0,
          primaryColor: Colors.teal[600],
          secondaryColor: Colors.white,
        ),
      ),
    );
  }
}