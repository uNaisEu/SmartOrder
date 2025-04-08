import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../login/domain/entities/user_entity.dart';
import '../../providers/order_provider.dart';
import '../widgets/orders.dart';


class OrdersPage extends StatelessWidget {
  const OrdersPage({ 
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.I<OrderProvider>()..fetchOrders(user)),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: const Text('Мои заказы'),
        ),
        body: const SafeArea(
          child: Orders()
        )
      ),
    );
  }
}