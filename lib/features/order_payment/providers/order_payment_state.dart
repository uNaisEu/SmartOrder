import '../../../core/error/failures.dart';
import '../domain/entities/order_entity.dart';


abstract class OrderPaymentState {}

class OrderPaymentInitial extends OrderPaymentState {}

class OrderPostLoading extends OrderPaymentState {}

class OrderPostSuccess extends OrderPaymentState {
  final OrderEntity order;
  OrderPostSuccess(this.order);
}

class PaymentLoading extends OrderPaymentState {}

class PaymentSuccess extends OrderPaymentState {
  final String paymentUrl;
  PaymentSuccess(this.paymentUrl);
}

class OrderPaymentFailed extends OrderPaymentState {
  final Failure failure;
  OrderPaymentFailed(this.failure);
}