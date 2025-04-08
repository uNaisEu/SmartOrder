import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';

class FetchOrdersUseCase {
  final OrderRepository repository;

  FetchOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> call(UserEntity user) async {
    return repository.fetchOrders(user: user);
  }
}
