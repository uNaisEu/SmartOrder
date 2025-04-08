import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../basket/providers/basket_provider.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../providers/order_payment_provider.dart';
import '../../providers/order_payment_state.dart';


class PaymentModalSheet extends StatefulWidget {
  const PaymentModalSheet({
    super.key, 
    required this.user,
    required this.basketProvider,
  });

  final UserEntity user;
  final BasketProvider basketProvider;

  @override
  State<PaymentModalSheet> createState() => _PaymentModalSheetState();
}

class _PaymentModalSheetState extends State<PaymentModalSheet> {
  OrderPaymentProvider orderPaymentProvider = GetIt.I<OrderPaymentProvider>();
  late List<OrderItemEntity> basket = widget.basketProvider.basket;

  @override
  void initState() {
    super.initState();
    orderPaymentProvider.postOrder(widget.user, basket);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrderPaymentState>(
      stream: orderPaymentProvider.state,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is OrderPostSuccess) {
          widget.basketProvider.clearBasket();
        } else if (state is OrderPaymentFailed) {
          showAnotherSnackBar(AppRouter.rootContext!, state.failure.message);
        }

        return Ink(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPostOrderWidget(state!),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostOrderWidget(OrderPaymentState state) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          "Оплата заказа",
          style: Theme.of(context).textTheme.titleLarge,
        ),

        if (state is OrderPostLoading) 
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
        
        if (state is OrderPostSuccess) 
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ваш заказ:",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    state.order.displayOrder,
                    style: Theme.of(context).textTheme.displayMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}