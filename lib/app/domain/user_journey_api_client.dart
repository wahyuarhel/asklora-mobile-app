import 'package:dio/dio.dart';
import 'dart:convert';

import '../../../../core/domain/endpoints.dart';
import '../../core/data/remote/asklora_api_client.dart';
import 'user_journey_request.dart';

class UserJourneyApiClient {
  Future<Response> get() async {
    var response = await AskloraApiClient().get(endpoint: endpointUserJourney);
    return response;
  }

  Future<Response> save(UserJourneyRequest request) async {
    var response = await AskloraApiClient().post(
        endpoint: endpointUserJourney, payload: json.encode(request.toJson()));
    return response;
  }
}
