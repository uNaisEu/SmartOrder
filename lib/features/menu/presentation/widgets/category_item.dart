import 'package:flutter/material.dart';

import '../../domain/entities/menu_entity.dart';
import 'dish_item.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({ 
    super.key,
    required this.menu,
    required this.observedIndex,
    required this.index,
  });

  final MenuEntity menu;
  final int observedIndex;
  final int index;

  @override
  Widget build(BuildContext context){
    return Ink(
      color: index == observedIndex 
          ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.6)
          : Colors.transparent,
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              menu.category.name,
              style: Theme.of(context).textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              itemExtent: 164,
              scrollDirection: Axis.horizontal,
              itemCount: menu.dishes.length,
              itemBuilder: (context, horizontalIndex) {
                final dish = menu.dishes[horizontalIndex];
                return DishItem(dish: dish);
              },
            ),
          ),
        ],
      ),
    );
  }
}