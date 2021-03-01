import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/order/order_bloc.dart';
import 'package:tul_shopping_cart/core/models/order_model.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';

class MyOrdersView extends StatefulWidget {
  MyOrdersView({Key key}) : super(key: key);

  @override
  _MyOrderViewState createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrdersView> {

  OrderBloc _orderBloc;
  bool _reverseList = false;

  @override
  void initState() {
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _orderBloc.add(OnInitOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _init()
      ),
    );
  }

  Widget _init(){
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if(state.exist){

          if(state.orders.isNotEmpty){
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mis pedidos', style: TextStyle(color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: Icon(Icons.filter_list_outlined, color: Colors.teal[600]),
                          onPressed: (){
                            setState(() {
                              _reverseList = !_reverseList;
                            });
                          }
                        )
                    ],
                  ), 
                ),
                _orderList(state.orders),
              ],
            );
          }else{
            return _ordersEmpty();
          }
        }else{
          return _loader();
        }
      },
    );
  }

  Widget _orderList(List<Order> orders){
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(top: 10.0),
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int i) { 
          int index = (_reverseList)? (orders.length-1)-i : i;
          return ListTile(
            title: Text('Pedido #${index+1}', style: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.bold),),
            subtitle: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text('Ver detalles', style: TextStyle(color: Colors.teal[600]))
              ),
              onTap: (){
                Navigator.of(context).pushNamed('order', arguments: {
                  'title': 'Pedido #${index+1}',
                  'index': index
                });
              },
            ),
            trailing: Chip(
              label: Text('Completado', style: TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.teal[600]
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }

  Widget _ordersEmpty(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_outlined, size: 70.0, color: Colors.teal[600]),
            SizedBox(height: 5.0),
            Text('No hay ordenes realizadas', style: TextStyle(color: Colors.grey[600], fontSize: 20.0, fontWeight: FontWeight.bold))
          ],
        )
      ),
    );
  }

  Widget _loader(){
    return Container(
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