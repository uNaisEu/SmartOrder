import '../../domain/entities/dish_entity.dart';
import 'category_model.dart';

class DishModel {
  final int id;
  final CategoryModel category;
  final String name;
  final String displayName;
  final String barcode;
  final double price;
  final double weight;
  final String unit;
  final bool available;
  final String imageUrl;

  DishModel({
    required this.id, 
    required this.category,
    required this.name,
    required this.displayName,
    required this.barcode,
    required this.price,
    required this.weight,
    required this.unit,
    required this.available,
    required this.imageUrl,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: int.parse(json['id'].toString()),
      category: CategoryModel.fromJson(json['category']),
      name: json['name'],
      displayName: json['display_name'],
      barcode: json['barcode'],
      price: double.parse(json['price'].toString()),
      weight: double.parse(json['weight'].toString()),
      unit: json['unit'],
      available: json['available'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.toJson(),
      'name': name,
      'display_name': displayName,
      'barcode': barcode,
      'price': price,
      'weight': weight,
      'unit': unit,
      'available': available,
      'image_url': imageUrl,
    };
  }

  DishEntity toEntity() {
    return DishEntity(
      id: id,
      category: category.toEntity(), 
      name: name, 
      barcode: barcode, 
      price: price, 
      weight: weight,
      unit: unit,
      imageUrl: imageUrl
    );
  }
}