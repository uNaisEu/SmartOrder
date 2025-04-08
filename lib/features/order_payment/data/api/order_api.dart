import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/services/order_storage_service.dart';
import '../../utils/order_utils.dart';
import '../models/create_order_model.dart';
import '../models/order_model.dart';


class OrderApi {
  Future<OrderModel> postOrder(CreateOrderModel requestOrder, String token) async {
    try {
      final orderStorage = GetIt.I<OrderStorageService>();

      int orderPosition = 1;
      final orderModels = await orderStorage.storageFetchOrder(token);
      if (orderModels != null) {
        orderPosition = orderModels.length;
      }

      final newOrderModel = OrderModel(
        id: orderPosition, 
        displayOrder: generateDisplayOrder(orderPosition), 
        statusDisplay: "Готовится", 
        createdAt: DateTime.now(), 
        totalPrice: requestOrder.items.fold(0, (sum, item) => sum + (item.price * item.quantity)),
        items: requestOrder.items
      );

      GetIt.I<OrderStorageService>().storagePostOrder(newOrderModel, token);
      return newOrderModel;
    } catch (e) {
      debugPrint("Неизвестная ошибка: $e");
      throw Exception("Неизвестная ошибка: попробуйте позже.");
    }
  }

  Future<List<OrderModel>> fetchOrders(String token) async {
    try {
      final orderStorage = GetIt.I<OrderStorageService>();
      final orderModels = await orderStorage.storageFetchOrder(token);
      if (orderModels != null) {
        return orderModels;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Неизвестная ошибка: $e");
      throw Exception("Неизвестная ошибка: попробуйте позже.");
    }
  }
}
