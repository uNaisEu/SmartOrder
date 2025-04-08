import 'category_entity.dart';
import 'dish_entity.dart';

class MenuEntity {
  final CategoryEntity category;
  final List<DishEntity> dishes;

  MenuEntity({
    required this.category, 
    required this.dishes,
  });
}