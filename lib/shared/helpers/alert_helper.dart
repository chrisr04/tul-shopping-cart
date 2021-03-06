import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/shared/widgets/loader_widget.dart';

void showOrderLoadingAlert(BuildContext context){

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        width: double.infinity,
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Loader(
              size: 25.0,
              primaryColor: Colors.teal[600],
              secondaryColor: Colors.white,
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Text('Procesando pedido...', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[600], fontSize: 16.0, fontWeight: FontWeight.bold))
            )
          ],
        ),
      )
    )
  );
}

void showOrderSuccessAlert(BuildContext context){

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 90.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline_rounded, size: 60.0, color: Colors.teal[600]),
            SizedBox(height: 5.0),
            Expanded(
              child: Text('¡Pedido realizado!', overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 18.0, fontWeight: FontWeight.bold))
            )
          ],
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 7.0, bottom: 3.0),
      actions: [
      GestureDetector(
          child: Text('Cerrar', style: TextStyle(color:  Colors.teal[600], fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: (){
            Navigator.of(context).pop();
          }
        )
      ]
    )
  );
}

void showProductDetailAlert(BuildContext context, String description){
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('Descripción del producto'),
      content: Container(
        child: Text(description),
      ),
      actionsPadding: EdgeInsets.only(right: 7.0, bottom: 3.0),
      actions: [
        GestureDetector(
          child: Text('Cerrar', style: TextStyle(color:  Colors.teal[600], fontSize: 16.0, fontWeight: FontWeight.bold)),
          onTap: (){
            Navigator.of(context).pop();
          }
        )
      ]
    ),
  );
}