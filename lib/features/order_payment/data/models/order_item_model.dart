import '../../../menu/data/models/dish_model.dart';
import '../../../menu/data/models/set_model.dart';
import '../../domain/entities/order_item_entity.dart';

class OrderItemModel {
  final int id;
  final DishModel? dish;
  final SetModel? set;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.id,
    this.dish,
    this.set,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: int.parse(json['id'].toString()),
      dish: json['dish'] != null ? DishModel.fromJson(json['dish']) : null,
      set: json['set'] != null ? SetModel.fromJson(json['set']) : null,
      quantity: int.parse(json['quantity'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dish': dish?.toJson(),
      'set': set?.toJson(),
      'quantity': quantity,
      'price': price,
    };
  }

  Map<String, dynamic> toPostJson() {
    if (dish != null) {
      return {
        'dish_id': dish!.id,
        'quantity': quantity,
      };
    } else if (set != null) {
      return {
        'set_menu_id': set!.id,
        'quantity': quantity,
      };
    } else {
      return {};
    }
  }

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      dish: dish?.toEntity(), 
      set: set?.toEntity(),
      quantity: quantity, 
      price: price
    );
  }
}