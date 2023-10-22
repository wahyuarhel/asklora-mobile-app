import '../../../core/domain/base_response.dart';
import '../domain/order_request.dart';
import '../domain/order_response.dart';
import '../domain/orders_api_client.dart';

class OrdersRepository {
  final OrdersApiClient _ordersApiClient = OrdersApiClient();

  Future<BaseResponse<OrderResponse>> submitOrder({
    required OrderRequest orderRequest,
  }) async {
    var response = await _ordersApiClient.submitOrder(orderRequest);
    return BaseResponse.complete(OrderResponse.fromJson(response.data));
  }
}
