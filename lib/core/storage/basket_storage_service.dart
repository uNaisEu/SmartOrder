import 'dart:convert';

import '../../features/order_payment/data/models/order_item_model.dart';
import '../../features/order_payment/domain/entities/order_item_entity.dart';
import 'shared_preferences_async.dart';

class BasketStorageService {

  static const _basketKey = 'basket';

  Future<void> setBasket(List<OrderItemEntity>? basket) async {
    final prefs = SharedPreferencesAsync.instance;

    if (basket != null) {
      await prefs.setStringList(
        'basket', 
        basket.map((item) => jsonEncode(item.toModel())).toList()
      );
    } else {
      await prefs.remove(_basketKey);
    }
  }

  Future<List<OrderItemEntity>?> getBasket() async {

    final prefs = SharedPreferencesAsync.instance;

    final basketModelString = prefs.getStringList(_basketKey);
    if (basketModelString != null) {
      final basketModels = basketModelString
          .map((jsonItem) => OrderItemModel.fromJson(jsonDecode(jsonItem)))
          .toList();
      final basket = basketModels
          .map((model) => model.toEntity()).toList();
      return basket;
    }
    return null;
  }
}