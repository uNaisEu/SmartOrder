import '../../../login/domain/entities/user_entity.dart';
import '../../domain/entities/order_entity.dart';
import 'order_item_model.dart';


class OrderModel {
  final int id;
  final String displayOrder;
  final String statusDisplay;
  final DateTime createdAt;
  final double totalPrice;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.displayOrder,
    required this.statusDisplay,
    required this.createdAt,
    required this.totalPrice,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['items'];
    final items = data.map((json) => OrderItemModel.fromJson(json)).toList();

    return OrderModel(
      id: json['id'],
      displayOrder: json['display_order'],
      statusDisplay: json['status_display'],
      createdAt: DateTime.parse(json['created_at'].toString()),
      totalPrice: double.parse(json['total_price'].toString()),
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_order': displayOrder,
      'status_display': statusDisplay,
      'created_at': createdAt.toIso8601String(),
      'total_price': totalPrice,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  OrderEntity toEntity(UserEntity user) {
    return OrderEntity(
      user: user, 
      displayOrder: displayOrder,
      statusDisplay: statusDisplay, 
      createdAt: createdAt, 
      totalPrice: totalPrice, 
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}