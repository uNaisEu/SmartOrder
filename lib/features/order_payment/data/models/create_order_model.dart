import 'order_item_model.dart';


class CreateOrderModel {
  final List<OrderItemModel> items;

  CreateOrderModel({
    required this.items,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['items'];
    final items = data.map((json) => OrderItemModel.fromJson(json)).toList();

    return CreateOrderModel(
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toPostJson()).toList(),
    };
  }
}