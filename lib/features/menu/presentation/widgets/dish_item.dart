import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_router.dart';
import '../../../order_payment/domain/entities/order_item_entity.dart';
import '../../../basket/providers/basket_provider.dart';
import '../../domain/entities/dish_entity.dart';
import 'dish_modal_sheet.dart';


class DishItem extends StatelessWidget {
  const DishItem({ 
    super.key,
    required this.dish,
  });

  final DishEntity dish;

  void openDishMenu(BuildContext context) {
    showModalBottomSheet(
      context: AppRouter.rootContext!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      builder: (context) => DishModalSheet(dish: dish),
    );
  }

  @override
  Widget build(BuildContext context){
    return Consumer<BasketProvider>(
      builder: (context, basketProvider, child) {
        int existingIndex =
            basketProvider.basket.indexWhere((item) => item.dish?.id == dish.id);
        OrderItemEntity? existingItem;
        if (existingIndex != -1) {
          existingItem = basketProvider.basket[existingIndex];
        }
        
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(
                children: [
                  Ink(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(dish.imageUrl)
                      ),
                    ),
                  ),
        
                  if (existingItem != null)
                    Positioned(
                      left: 4,
                      top: 4,
                      child: Ink(
                        height: 48,
                        width: 48,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            existingItem.quantity.toString(),
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
        
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: InkWell(
                      onTap: () => openDishMenu(context),
                      customBorder: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(8.0), 
                        ),
                      ),
                      child: Ink(
                        height: 48,
                        width: 48,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Ink(
                            height: 32,
                            width: 32,
                            decoration: ShapeDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              shape: const CircleBorder(),
                            ),
                            child: Icon(
                              existingItem != null 
                                  ? Icons.edit_outlined
                                  : Icons.add,
                              size: 18,
                              color: Theme.of(context).colorScheme.onPrimaryContainer
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  dish.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "${dish.price} ₽",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'Roboto'),
                ),
              ),
              Text(
                "${dish.weight} ${dish.unit}",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        );
      }
    );
  }
}