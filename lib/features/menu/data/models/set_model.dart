import '../../domain/entities/set_entity.dart';
import 'dish_model.dart';

class SetModel {
  final int id;
  final String name;
  final double price;
  final bool available;
  final List<DishModel> dishes;

  SetModel({
    required this.id, 
    required this.name,
    required this.price,
    required this.available,
    required this.dishes,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['dishes'];
    final dishes = data.map((json) => DishModel.fromJson(json)).toList();

    return SetModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      price: double.parse(json['price'].toString()),
      available: json['available'],
      dishes: dishes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'available': available,
      'dishes': dishes.map((item) => item.toJson()).toList(),
    };
  }

  SetEntity toEntity() {
    return SetEntity(
      id: id,
      name: name, 
      price: price, 
      available: available, 
      dishes: dishes.map((item) => item.toEntity()).toList(),
    );
  }
}