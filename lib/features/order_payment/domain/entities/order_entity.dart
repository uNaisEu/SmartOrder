import '../../../login/domain/entities/user_entity.dart';
import 'order_item_entity.dart';

class OrderEntity {
  final UserEntity user;
  final String displayOrder;
  final String statusDisplay;
  final DateTime createdAt;
  final double totalPrice;
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.user,
    required this.displayOrder,
    required this.statusDisplay,
    required this.createdAt,
    required this.totalPrice,
    required this.items,
  });
}