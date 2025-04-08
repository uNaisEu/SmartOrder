import '../../../../core/error/exceptions.dart';
import '../api/order_api.dart';
import '../models/create_order_model.dart';
import '../models/order_model.dart';

abstract interface class OrderRemoteDataSource {  
  Future<OrderModel> postOrder({
    required CreateOrderModel request,
    required String token,
  });

  Future<List<OrderModel>> fetchOrders({
    required String token,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApi api;

  OrderRemoteDataSourceImpl(this.api);

  @override
  Future<OrderModel> postOrder({
    required CreateOrderModel request,
    required String token,
  }) async {
    try {
      OrderModel response = await api.postOrder(request, token);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<OrderModel>> fetchOrders({
    required String token,
  }) async {
    try {
      List<OrderModel> response = await api.fetchOrders(token);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}