import '../../data/models/category_model.dart';

class CategoryEntity {
  final int id;
  final String name;
  final int availableDishesCount;

  CategoryEntity({
    required this.id,
    required this.name, 
    required this.availableDishesCount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity && other.id == id && other.name == name && other.availableDishesCount == availableDishesCount);

  @override
  int get hashCode => id.hashCode ^ availableDishesCount.hashCode ^ name.hashCode;

  CategoryModel toModel() {
    return CategoryModel(
      id: id, 
      name: name, 
      availableDishesCount: availableDishesCount
    );
  }
}