import '../../data/models/set_model.dart';
import 'dish_entity.dart';

class SetEntity {
  final int id;
  final String name;
  final double price;
  final bool available;
  final List<DishEntity> dishes;

  SetEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.dishes,
  });

  SetModel toModel() {
    return SetModel(
      id: id, 
      name: name, 
      price: price, 
      available: available, 
      dishes: dishes.map((item) => item.toModel()).toList(),
    );
  }
}