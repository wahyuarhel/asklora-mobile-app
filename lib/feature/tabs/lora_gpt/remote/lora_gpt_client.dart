import '../../../../core/data/remote/base_api_client.dart';
import '../../../../core/utils/build_configs/build_config.dart';

class LoraGptApiClient extends BaseApiClient {
  LoraGptApiClient._internal() : super();

  static final _singleton = LoraGptApiClient._internal();

  factory LoraGptApiClient() => _singleton;

  @override
  String get baseUrl => Environment().config.askloraAiBaseUrl;
}
