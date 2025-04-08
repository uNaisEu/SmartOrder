import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../entities/order_entity.dart';
import '../entities/order_item_entity.dart';


abstract interface class OrderRepository {
  Future<Either<Failure, OrderEntity>> postOrder({
    required UserEntity user,
    required List<OrderItemEntity> items
  });

  Future<Either<Failure, List<OrderEntity>>> fetchOrders({
    required UserEntity user,
  });
}
