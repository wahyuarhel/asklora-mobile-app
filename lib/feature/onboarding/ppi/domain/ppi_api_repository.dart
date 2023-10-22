import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/data/remote/ppi_api_client.dart';
import '../../../../core/domain/endpoints.dart';
import 'bot_submission_request.dart';
import 'ppi_user_response_request.dart';

class PpiApiRepository {
  Future<Response> fetchPersonalAndPrivacyQuestions() async =>
      await PpiApiClient().get(endpoint: endpointQuestion);

  Future<Response> fetchInvestmentStyleQuestions(String accountId) async =>
      await PpiApiClient().get(endpoint: '$endpointQuestion/$accountId');

  Future<Response> postQuestionAnswer(PpiSelectionRequest request) async =>
      await PpiApiClient().post(
          endpoint: endpointAddAnswer, payload: json.encode(request.toJson()));

  Future<Response> postBulkAnswer(List<PpiSelectionRequest> request) async =>
      await PpiApiClient()
          .post(endpoint: endpointAddAnswer, payload: jsonEncode(request));

  Future<Response> getUserSnapshotByUserId(dynamic userId) async =>
      await PpiApiClient().get(endpoint: '$endpointGetUser/$userId');

  Future<Response> getUserSnapshotByAskloraId(int askloraId) async =>
      await PpiApiClient()
          .get(endpoint: '$endpointGetSnapshotByAskloraId/$askloraId');

  Future<Response> postBotChoice(BotSubmissionRequest request) async =>
      await PpiApiClient().post(
          endpoint: endpointAddBotChoice,
          payload: json.encode(request.toJson()));

  Future<Response> linkUser(int userId) async => await PpiApiClient()
      .post(endpoint: '$endpointLinkedUser/$userId', payload: json.encode(''));
}
