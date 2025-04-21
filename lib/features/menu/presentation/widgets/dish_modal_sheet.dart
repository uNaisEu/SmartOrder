import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../order_payment/domain/entities/order_item_entity.dart';
import '../../../basket/providers/basket_provider.dart';
import '../../domain/entities/dish_entity.dart';


class DishModalSheet extends StatefulWidget {
  const DishModalSheet({ 
    super.key,
    required this.dish
  });

  final DishEntity dish; 

  @override
  State<DishModalSheet> createState() => _DishModalSheetState();
}

class _DishModalSheetState extends State<DishModalSheet> {
  final basketProvider = GetIt.I<BasketProvider>();
  OrderItemEntity? existingItem;

  int quantity = 1;
  bool isInBasket = false;

  @override
  void initState() {
    super.initState();
    int existingIndex =
        basketProvider.basket.indexWhere((item) => item.dish?.id == widget.dish.id);
    if (existingIndex != -1) {
      setState(() {
        isInBasket = true;
        existingItem = basketProvider.basket[existingIndex];
        quantity = existingItem!.quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            widget.dish.imageUrl,
            height: 180,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "${widget.dish.name} (${widget.dish.weight} ${widget.dish.unit})",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              Expanded(
                child: Text(
                  "${widget.dish.price.toStringAsFixed(2)} ₽",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'Roboto'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "x$quantity",
                style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'Roboto'),
              ),
              const SizedBox(width: 48),
              Text(
                "${(widget.dish.price * quantity).toStringAsFixed(2)} ₽",
                style: Theme.of(context).textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'Roboto'),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                height: 48,
                width: 135,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$quantity", 
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold, 
                              color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: quantity >= 99
                            ? null
                            : () {
                                setState(() {
                                  quantity++;
                                });
                              },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    basketProvider.addOrSetItem(widget.dish, quantity);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        isInBasket ? "Изменить" : "В корзину",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    ),
                  ),
                ),
              ),
              
              if (isInBasket)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      basketProvider.removeItem(existingItem!);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                    )
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
