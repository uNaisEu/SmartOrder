import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';


class CategoryNavigationBar extends StatelessWidget {
  const CategoryNavigationBar({ 
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onPressed,
  });

  final List<CategoryEntity> categories;
  final int selectedIndex;
  final Function(int index) onPressed;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
      padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...categories.asMap().map((index, category) {
              return MapEntry(
                index,
                customTextButton(
                  context, 
                  index: index,
                  title: category.name, 
                  onPressed: onPressed,
                ),
              );
            }).values,
          ],
        ),
      ),
    );
  }

  Widget customTextButton(BuildContext context, {int index = -1, String title = "", Function(int)? onPressed}) {
    return TextButton(
      onPressed: onPressed != null 
          ? () {
            onPressed(index);
          } : null,
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        foregroundColor: selectedIndex == index
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurface,
        shape: LinearBorder.bottom(
          side: selectedIndex == index
              ? BorderSide(
                  width: 2,
                  color: selectedIndex == index 
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurface,
                ) 
              : BorderSide.none
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!
            .copyWith(fontWeight: FontWeight.bold, 
              color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}