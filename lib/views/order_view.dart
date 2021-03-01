import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tul_shopping_cart/core/blocs/order/order_bloc.dart';
import 'package:tul_shopping_cart/core/models/order_model.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';

class OrderView extends StatefulWidget {

  final String title;
  final int index;

  OrderView({Key key, this.title, this.index}) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {

  OrderBloc _orderBloc;

  @override
  void initState() { 
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _orderBloc.add(OnLoadProductsOrder(widget.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Resumen de ${widget.title}'),
        backgroundColor: Colors.teal[600]
      ),
      body: _init(),
    );
  }

  Widget _init() {
    
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        Order order = state.orders[widget.index];
        if(order.isProductsLoaded){
          List<Map<String, dynamic>> records = order.records;
          return _body(records);
        }else{
          return _loader();
        }
      },
    );
  }

  Widget _body(List<Map<String, dynamic>> records){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top:30.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(child: Text('Productos', style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.bold))),
              Text('Cant', style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        _recordsList(records),
        _statusInfo()
      ],
    );
  }

  Widget _recordsList(List<Map<String, dynamic>> records){
    return Expanded(
      child: ListView.builder(
        itemCount: records.length,
        itemBuilder: (BuildContext context, int index) {  
          return ListTile(
            title: Text(records[index]['product'].name, style: TextStyle(fontSize: 17.0)),
            trailing: Text('${records[index]['quantity']}', style: TextStyle(color: Colors.teal[600], fontSize: 17.0, fontWeight: FontWeight.bold)),
          );
        },
      )
    );
  }

  Widget _statusInfo(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.teal[600].withOpacity(0.3)
      ),
      child: Center(
        child: Text('Este pedido fue realizado con éxito', style: TextStyle(color: Colors.teal[600], fontWeight: FontWeight.bold)),
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