import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final int availableDishesCount;

  CategoryModel({
    required this.id, 
    required this.name, 
    required this.availableDishesCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      availableDishesCount: int.parse(json['available_dishes_count'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'available_dishes_count': availableDishesCount,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      availableDishesCount: availableDishesCount,
    );
  }
}