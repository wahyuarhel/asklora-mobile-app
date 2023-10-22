import 'base_api_client.dart';

class AskloraApiClient extends BaseApiClient {
  AskloraApiClient._internal() : super();

  static final _singleton = AskloraApiClient._internal();

  factory AskloraApiClient() => _singleton;
}
