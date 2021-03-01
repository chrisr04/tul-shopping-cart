part of 'order_bloc.dart';

@immutable
class OrderState {

  final List<Order> orders;
  final bool exist;

  OrderState({
    List<Order> orders
  }): this.orders = orders?? [],
      this.exist = (orders != null)? true : false;

  OrderState copyWith({
    List<Order> orders
  }) => OrderState(
    orders: orders?? this.orders
  );

}

