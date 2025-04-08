import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../entities/order_entity.dart';
import '../entities/order_item_entity.dart';
import '../repositories/order_repository.dart';


class PostOrderUseCase {
  final OrderRepository repository;

  PostOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(UserEntity user, List<OrderItemEntity> items) async {
    return await repository.postOrder(
      user: user, 
      items: items
    );
  }
}
