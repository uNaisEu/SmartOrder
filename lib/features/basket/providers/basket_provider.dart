import 'package:flutter/material.dart';


import '../../../core/storage/basket_storage_service.dart';
import '../../menu/domain/entities/dish_entity.dart';
import '../../order_payment/domain/entities/order_item_entity.dart';


class BasketProvider extends ChangeNotifier {
  final BasketStorageService _storage;

  List<OrderItemEntity> _basket = [];

  BasketProvider({
    required BasketStorageService storage
  }) : _storage = storage {
    _initialize();
  }

  List<OrderItemEntity> get basket => _basket;

  int get itemCount => _basket.length;

  double get totalPrice =>
      _basket.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> _initialize() async {
    final basketList = await _storage.getBasket();
    if (basketList != null) {
      _basket = basketList;
    }
  }

  void addOrSetItem(DishEntity dish, int quantity) async {
    int existingIndex =
        _basket.indexWhere((item) => item.dish?.id == dish.id);
    if (existingIndex != -1) {
      _basket[existingIndex] = OrderItemEntity(
        id: _basket[existingIndex].id,
        dish: dish,
        set: _basket[existingIndex].set,
        quantity: quantity,
        price: dish.price * quantity,
      );
    } else {
      _basket.add(OrderItemEntity(
        id: _basket.length + 1,
        dish: dish,
        set: null,
        quantity: quantity,
        price: dish.price * quantity,
      ));
    }

    await _storage.setBasket(_basket);
    notifyListeners();
  }

  void removeItem(OrderItemEntity item) async {
    _basket.remove(item);
    await _storage.setBasket(_basket);
    notifyListeners();
  }

  void clearBasket() async {
    _basket.clear();
    await _storage.setBasket(_basket);
    notifyListeners();
  }
}