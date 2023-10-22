import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/data/remote/asklora_api_client.dart';
import '../../../core/domain/endpoints.dart';
import 'order_request.dart';

class OrdersApiClient {
  Future<Response> submitOrder(OrderRequest request) async =>
      await AskloraApiClient().post(
          endpoint: endpointOrders, payload: jsonEncode(request.toJson()));
}
