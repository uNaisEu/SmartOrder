import 'package:flutter/material.dart';

import '../../login/domain/entities/user_entity.dart';
import '../domain/entities/order_entity.dart';
import '../domain/usecases/fetch_orders_usecase.dart';


class OrderProvider extends ChangeNotifier {
  final FetchOrdersUseCase fetchOrdersUseCase;

  OrderProvider(this.fetchOrdersUseCase);

  List<OrderEntity> _orders = [];

  List<OrderEntity> get orders => _orders;

  void fetchOrders(UserEntity user) async {
    final result = await fetchOrdersUseCase.call(user);
    result.fold(
      (failure) => _orders = [],
      (orders) => _orders = orders,
    );
    notifyListeners();
  }
}