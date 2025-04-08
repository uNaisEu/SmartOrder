import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../../login/domain/entities/user_entity.dart';
import '../domain/entities/order_item_entity.dart';
import '../domain/usecases/post_order_usecase.dart';
import 'order_payment_state.dart';


class OrderPaymentProvider {
  final PostOrderUseCase _postOrderUseCase;
  final _stateController = BehaviorSubject<OrderPaymentState>.seeded(OrderPaymentInitial());

  Stream<OrderPaymentState> get state => _stateController.stream;

  OrderPaymentProvider ({
    required PostOrderUseCase postOrderUseCase,
  }) : _postOrderUseCase = postOrderUseCase {
    _stateController.add(OrderPaymentInitial());
  }

  Future<void> postOrder(UserEntity user, List<OrderItemEntity> items) async {
    _stateController.add(OrderPostLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _postOrderUseCase.call(user, items);
    result.fold(
      (failure) => _stateController.add(OrderPaymentFailed(failure)),
      (order) => _stateController.add(OrderPostSuccess(order)),
    );
  }
}