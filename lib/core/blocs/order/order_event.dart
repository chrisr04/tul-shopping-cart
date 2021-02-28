part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OnInitOrders extends OrderEvent{ }

class OnLoadProductsOrder extends OrderEvent{
  final int index;
  OnLoadProductsOrder(this.index);
}
