import '../../../menu/domain/entities/dish_entity.dart';
import '../../../menu/domain/entities/set_entity.dart';
import '../../data/models/order_item_model.dart';

class OrderItemEntity {
  final int id;
  final DishEntity? dish;
  final SetEntity? set;
  final int quantity;
  final double price;

  OrderItemEntity({
    required this.id,
    this.dish,
    this.set,
    required this.quantity,
    required this.price,
  });

  OrderItemModel toModel() {
    return OrderItemModel(
      id: id, 
      dish: dish?.toModel(), 
      set: set?.toModel(), 
      quantity: quantity, 
      price: price
    );
  }
}