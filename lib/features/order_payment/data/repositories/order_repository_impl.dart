import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/constants_text.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/connection_checker.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/create_order_model.dart';
import '../models/order_model.dart';


class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  OrderRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, OrderEntity>> postOrder({
    required UserEntity user,
    required List<OrderItemEntity> items,
  }) {
    return _postOrder(
      user,
      () async => await remoteDataSource.postOrder(
        request: CreateOrderModel(
          items: items.map((item) => item.toModel()).toList(),
        ),
        token: user.moodleToken,
      ),
    );
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> fetchOrders({
    required UserEntity user
  }) {
    return _fetchOrders(
      user,
      () async => await remoteDataSource.fetchOrders(
        token: user.moodleToken,
      ),
    );
  }

  Future<Either<Failure, OrderEntity>> _postOrder(
    UserEntity user,
    Future<OrderModel> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(ConstantsText.noConnectionErrorMessage));
      }
      final response = await fn();
      OrderEntity order = response.toEntity(user);
      
      return right(order);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, List<OrderEntity>>> _fetchOrders(
    UserEntity user,
    Future<List<OrderModel>> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(ConstantsText.noConnectionErrorMessage));
      }
      final response = await fn();
      List<OrderEntity> orders = response.map((e) => e.toEntity(user)).toList();
      
      return right(orders);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}