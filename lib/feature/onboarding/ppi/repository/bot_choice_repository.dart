import '../domain/bot_submission_request.dart';
import '../domain/ppi_api_repository.dart';
import '../domain/ppi_user_response.dart';

class BotChoiceRepository {
  static BotChoiceRepository? _instance;

  factory BotChoiceRepository() => _instance ??= BotChoiceRepository._();

  BotChoiceRepository._();

  final PpiApiRepository _ppiApiClient = PpiApiRepository();

  Future<PpiUserResponse> addAnswer(
      BotSubmissionRequest botSubmissionRequest) async {
    var response = await _ppiApiClient.postBotChoice(botSubmissionRequest);

    return PpiUserResponse.fromJson(response.data);
  }
}
