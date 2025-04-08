import '../../data/models/dish_model.dart';
import 'category_entity.dart';


class DishEntity {
  final int id;
  final CategoryEntity category;
  final String name;
  final String barcode;
  final double price;
  final double weight;
  final String unit;
  final String imageUrl;

  DishEntity({
    required this.id,
    required this.category,
    required this.name,
    required this.barcode,
    required this.price,
    required this.weight,
    required this.unit,
    required this.imageUrl,
  });

  DishModel toModel() {
    return DishModel(
      id: id, 
      category: category.toModel(),
      name: name, 
      displayName: name, 
      barcode: barcode, 
      price: price, 
      weight: weight, 
      unit: unit, 
      available: true, 
      imageUrl: imageUrl
    );
  }
}