import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/constants_text.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../../../login/providers/login_provider.dart';
import '../../../login/providers/login_state.dart';
import '../../../order_payment/presentation/widgets/payment_modal_sheet.dart';
import '../../../order_payment/domain/entities/order_item_entity.dart';
import '../../providers/basket_provider.dart';


class Basket extends StatefulWidget {
  const Basket({ super.key });

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  bool isProcessing = false;

  Future<void> buy(UserEntity? user, BasketProvider basketProvider) async {
    if (user != null) {
      showModalBottomSheet(
        context: AppRouter.rootContext!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
        ),
        builder: (context) => PaymentModalSheet(user: user, basketProvider: basketProvider),
      );
    } else {
      showAnotherSnackBar(AppRouter.rootContext!, ConstantsText.authRequiredMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginState>(
      stream: GetIt.I<LoginProvider>().state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        UserEntity? user;
        if (state is LoginAuthenticated) {
          user = state.user;
        } 
        return Consumer<BasketProvider>(
          builder: (context, basketProvider, child) {
            List<OrderItemEntity> basket = basketProvider.basket;
            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Заказ',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(
                                onPressed: basket.isNotEmpty 
                                    ? () {
                                      basketProvider.clearBasket();
                                    } : null,
                                icon: const Icon(Icons.delete_rounded)
                              ),
                            )
                          ],
                        ),
                      ),
                      SliverList.separated(
                        itemCount: basket.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(basket[index].dish?.name ?? ""),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              final removedItem = basket[index];
                              basketProvider.removeItem(removedItem);
        
                              if (basket.contains(removedItem)) return;
                            },
                            background: Container(
                              color: Theme.of(context).colorScheme.error,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Theme.of(context).colorScheme.error, 
                                    width: 8
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(basket[index].dish?.imageUrl ?? "")
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${basket[index].dish?.name} / ${basket[index].dish?.weight} ${basket[index].dish?.unit}",
                                    style: Theme.of(context).textTheme.bodyLarge
                                  ),
                                  subtitle: Text(
                                    "${basket[index].price} ₽",
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold, 
                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                          fontFamily: 'Roboto'),
                                  ),
                                  trailing: Container(
                                    height: 48,
                                    width: 135,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            if (basket[index].quantity > 1) {
                                              basketProvider.addOrSetItem(basket[index].dish!, basket[index].quantity - 1);
                                            } else {
                                              basketProvider.removeItem(basket[index]);
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${basket[index].quantity}", 
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyLarge!
                                                .copyWith(fontWeight: FontWeight.bold, 
                                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                  fontFamily: 'Roboto'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: basket[index].quantity >= 99
                                                ? null
                                                : () {
                                                    basketProvider.addOrSetItem(
                                                      basket[index].dish!,
                                                      basket[index].quantity + 1,
                                                    );
                                                  },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, 
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'К оплате: ${basketProvider.totalPrice.toStringAsFixed(2)} ₽',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: basket.isNotEmpty && !isProcessing
                            ? () async => await buy(user, basketProvider)
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Text(
                              "Оплатить",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }
}
