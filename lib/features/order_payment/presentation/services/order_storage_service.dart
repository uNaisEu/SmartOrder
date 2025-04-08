import 'dart:convert';

import '../../data/models/order_model.dart';
import '../../../../core/storage/shared_preferences_async.dart';


class OrderStorageService {
  
  Future<void> storagePostOrder(OrderModel order, String token) async {
    final prefs = SharedPreferencesAsync.instance;

    List<OrderModel>? orders = await storageFetchOrder(token);
    if (orders != null) {
      orders.add(order);
    } else {
      orders = [order];
    }

    await prefs.setString(
      token, 
      jsonEncode(orders.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<OrderModel>?> storageFetchOrder(String token) async {
    final prefs = SharedPreferencesAsync.instance;
    
    final orderModelString = prefs.getString(token);
    if (orderModelString != null) {
      try {
        final decodedJson = jsonDecode(orderModelString) as List<dynamic>;
        final orders = decodedJson
            .map((order) => OrderModel.fromJson(order as Map<String, dynamic>))
            .toList();
        return orders;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}