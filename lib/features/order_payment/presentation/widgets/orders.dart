import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';


class Orders extends StatelessWidget {
  const Orders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.orders;
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
        
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text('Заказ №${order.displayOrder}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Статус: ${order.statusDisplay}'),
                    Text('Дата: ${order.createdAt.toLocal()}'),
                    Text('Сумма: ${order.totalPrice.toStringAsFixed(2)} руб'),
                    const SizedBox(height: 10),
                    Column(
                      children: order.items.map((item) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          title: item.dish != null
                              ? Text('${item.dish!.name} (x${item.quantity})')
                              : Text('${item.set!.name} (x${item.quantity})'),
                          trailing: Text('${item.price.toStringAsFixed(2)} руб'),
                        );
                      }).toList(),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
