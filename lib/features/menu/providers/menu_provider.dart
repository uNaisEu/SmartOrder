import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../domain/entities/category_entity.dart';
import '../domain/entities/dish_entity.dart';
import '../domain/entities/menu_entity.dart';
import '../domain/usecases/get_dishes_usecase.dart';
import 'menu_state.dart';


class MenuProvider {
  final GetDishesUseCase getDishesUseCase;
  final _stateController = BehaviorSubject<MenuState>.seeded(MenuInitial());

  MenuProvider(this.getDishesUseCase) {
    getMenu();
  }

  Stream<MenuState> get state => _stateController.stream;
  MenuState get currentState => _stateController.value;

  Future<void> getMenu() async {
    _stateController.add(MenuLoading());

    final result = await getDishesUseCase.call();
    result.fold(
      (failure) => _stateController.add(MenuLoadingFailed(failure)),
      (dishes) => _stateController.add(MenuLoaded(_groupDishesByCategory(dishes))),
    );
  }

  List<MenuEntity> _groupDishesByCategory(List<DishEntity> dishes) {
    final Map<CategoryEntity, List<DishEntity>> groupedDishes = {};

    for (var dish in dishes) {
      groupedDishes.putIfAbsent(dish.category, () => []).add(dish);
    }

    final menuList = groupedDishes.entries
        .map((entry) => MenuEntity(category: entry.key, dishes: entry.value))
        .toList();
    return menuList;
  }
}