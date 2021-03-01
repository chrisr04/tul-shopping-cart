import 'package:flutter/material.dart';
import 'package:tul_shopping_cart/core/models/product_model.dart';
import 'package:tul_shopping_cart/shared/widgets/product_card_widget.dart';

class ProductGrid extends StatelessWidget {

  final List<Product> products;

  const ProductGrid({
    Key key,
    @required this.products
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.13),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.89,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0
        ),
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0, bottom: 20.0),
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index){
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}